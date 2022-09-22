//
//  PokemonStats.swift
//  Pokedex
//
//  Created by Wanaldino Antimonio on 21/9/22.
//

import SwiftUI
import PokedexModel

struct PokemonStats: View {
	@Binding var pokemon: Pokemon

    var body: some View {
		GeometryReader { proxy in
			let textWidth = proxy.size.width * 0.3
			let valueWidth = 30.0
			let columns = [GridItem(.flexible(minimum: 0, maximum: textWidth)), GridItem(.fixed(valueWidth)), GridItem()]
			LazyVGrid(columns: columns, alignment: .leading, spacing: 10) {
				ForEach(pokemon.stats) { stat in
					Text(stat.name.replacingOccurrences(of: "Special", with: "Sp."))
						.font(.medium(size: 18))
						.foregroundColor(Color.gray)
					Text(stat.value.description)
						.font(.book(size: 16))

					let value = Double(stat.value)
					let maxValue = Double(Pokemon.Stat.maxValue)
					ProgressView(value: value, total: maxValue)
						.tint(value / maxValue < 0.4 ? .red : .green)
						.animation(.linear, value: pokemon)
				}
			}
			.padding(.horizontal)
		}
    }
}

struct PokemonStats_Previews: PreviewProvider {
    static var previews: some View {
		PokemonStats(pokemon: .constant(Pokemon.mock))
    }
}
