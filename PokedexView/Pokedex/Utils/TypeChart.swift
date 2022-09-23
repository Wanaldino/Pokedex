//
//  TypeChart.swift
//  Pokedex
//
//  Created by Wanaldino Antimonio on 22/9/22.
//

import Foundation
import PokedexModel
#if DEBUG
import PokedexAPI_DEV
#else
import PokedexAPI
#endif

actor TypeManager {
	struct MixedEffectivity: Identifiable {
		var id: Int { targetType }
		let targetType: Int
		var value: Double
	}

	static let shared = TypeManager()

	let client = HTTPClient()

	var types: [PokemonType]?
	var typeChart: [TypeEffectivity]?

	func retrieveTypes() async {
		types = try? await client.request(query: TypeList()).types
	}

	func retrieveChart() async {
		typeChart = try? await client.request(query: TypeChart()).effectivities
	}

	func type(with id: Int) async -> PokemonType {
		guard let types else {
			await retrieveTypes()
			return await type(with: id)
		}

		return types.first(where: { $0.id == id })!
	}

	func effectivity(attacker types: [PokemonType]) async -> [MixedEffectivity] {
		guard let typeChart else {
			await retrieveChart()
			return await effectivity(attacker: types)
		}

		let attackerTypeIDs = types.map(\.id)
		return typeChart
			.filter({ attackerTypeIDs.contains($0.attackerID) })
			.reduce([MixedEffectivity]()) { partialResult, effectivity in
				var result = partialResult
				if let index = result.firstIndex(where: { $0.targetType == effectivity.defenerID }) {
					result[index].value *= effectivity.value
				} else {
					result.append(MixedEffectivity(targetType: effectivity.defenerID, value: effectivity.value))
				}
				return result
			}
	}

	func effectivity(defender types: [PokemonType]) async -> [MixedEffectivity] {
		guard let typeChart else {
			await retrieveChart()
			return await effectivity(defender: types)
		}

		let defenderTypeIDs = types.map(\.id)
		return typeChart
			.filter({ defenderTypeIDs.contains($0.defenerID) })
			.reduce([MixedEffectivity]()) { partialResult, effectivity in
				var result = partialResult
				if let index = result.firstIndex(where: { $0.targetType == effectivity.attackerID }) {
					result[index].value *= effectivity.value
				} else {
					result.append(MixedEffectivity(targetType: effectivity.attackerID, value: effectivity.value))
				}
				return result
			}
	}
}
