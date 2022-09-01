//
//  PokedexList.swift
//  Pokedex
//
//  Created by Wanaldino Antimonio on 9/8/22.
//

import SwiftUI

struct PokedexList: View {
	@State var pokemons: [PokemonInfo]
	@State private var contentSize: CGSize = .zero

	let padding = 16.0
	func columns(for width: CGFloat) -> [GridItem] {
		let column = GridItem(.flexible())
		var numberOfColumns: Int
		let columnWidth = width / 2 - padding * 2
		if columnWidth < 200 {
			numberOfColumns = 1
		} else {
			numberOfColumns = 2
		}
		return Array(repeating: column, count: numberOfColumns)
	}

    var body: some View {
		GeometryReader { proxy in
			ScrollView {
				let columns = columns(for: proxy.size.width)
				LazyVGrid(columns: columns, alignment: .leading, content: {
					ForEach(pokemons) { pokemon in
						NavigationLink(value: Screen.detail(pokemons, pokemon)) {
							PokedexItemList(pokemon: pokemon)
								.frame(height: 200)
						}
					}
				})
				.padding(.all, padding)
			}
		}
		.task({
			do {
				let response = try await HTTPClient().request(query: PokemonList())
				self.pokemons = response.pokemons
			} catch (let error) {
				print(error)
			}
		})
		.navigationTitle("Pokedex")
    }
}

struct PokedexList_Previews: PreviewProvider {
    static var previews: some View {
		PokedexList(pokemons: PokemonInfo.mocks)

		PokedexList(pokemons: PokemonInfo.mocks)
			.previewDevice("iPad Air (5th generation)")
			.previewLayout(.device)
    }
}
