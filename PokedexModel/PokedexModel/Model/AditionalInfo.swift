//
//  Pokemon+AditionalInfo.swift
//  PokedexModel
//
//  Created by Wanaldino Antimonio on 21/9/22.
//

import Foundation

extension Pokemon {
	public struct AditionalInfo: Decodable {
		public let species: [Specie]
		public let descriptions: [Description]
		public let eggGroups: [EggGroup]
		let gender_rate: Int
	}
}

//Mark: - Specie
extension Pokemon.AditionalInfo {
	public struct Specie: Decodable {
		public let name: String
	}
}

extension Pokemon.AditionalInfo {
	public struct Description: Decodable {
		public let description: String
	}
}

extension Pokemon.AditionalInfo {
	public struct EggGroup: Decodable {
		public struct Group: Decodable {
			public struct GroupInfo: Decodable {
				public let name: String
			}
			public let names: [GroupInfo]
		}
		public let group: Group
	}
}

extension Pokemon.AditionalInfo {
	public enum Gender: Hashable {
		case male(Double)
		case female(Double)
		case genderless

		public var rate: Double {
			switch self {
			case .male(let rate): return rate
			case .female(let rate): return rate
			case .genderless: return 1
			}
		}

		public var image: String? {
			switch self {
			case .female: return "female_sign"
			case .male: return "male_sign"
			case .genderless: return nil
			}
		}
	}

	public var genders: [Gender] {
		guard gender_rate != -1 else { return [.genderless] }

		var female: Gender?
		let femaleRatio = Double(gender_rate) / 8
		if femaleRatio > 0 {
			female = .female(femaleRatio)
		}

		var male: Gender?
		let maleRatio = 1 - femaleRatio
		if maleRatio > 0 {
			male = .male(maleRatio)
		}

		return [male, female].compactMap({ $0 })
	}
}
