//
//  PokemonBasicDetail.swift
//  Pokedex
//
//  Created by Wanaldino Antimonio on 11/8/22.
//

import SwiftUI
import PokedexModel

struct PokemonBasicDetail: View {
	let pokemon: Pokemon
	
    var body: some View {
		GeometryReader { proxy in
			VStack(spacing: 16) {
				if let description = pokemon.description {
					Text(description)
				}

				let horizontalPadding = 16.0
				let availableWidth = proxy.size.width - 2 * horizontalPadding

				HStack(spacing: 0) {
					VerticalDescription(title: "Heigth", description: pokemon.height.description)
						.frame(width: availableWidth / 2, alignment: .leading)
					VerticalDescription(title: "Weight", description: pokemon.weight.description)
						.frame(width: availableWidth / 2, alignment: .leading)
				}
				.padding(.horizontal, horizontalPadding)
				.padding(.vertical, 8)
				.background {
					Rectangle()
						.foregroundColor(.white)
						.shadow(radius: 3)
				}

				Text("Breeding")

				let maxWidth = proxy.size.width / 3
				let columns = [GridItem(.flexible(minimum: 0, maximum: maxWidth)), GridItem()]
				LazyVGrid(columns: columns, alignment: .leading) {
					Text("Gender")
					Text("1")
					Text("Egg group")
					Text("1")
					Text("Egg cycle")
					Text("1")
				}.border(.red)

				Spacer()
			}
		}
		.padding(.horizontal, 16)
    }

	@ViewBuilder
	func VerticalDescription(title: String, description: String) -> some View {
		VStack(alignment: .leading) {
			Text(title)
			Text(description)
		}
	}
}

struct PokemonBasicDetail_Previews: PreviewProvider {
    static var previews: some View {
		PokemonBasicDetail(pokemon: .mock)
    }
}
