//
//  PokedexList.swift
//  Pokedex
//
//  Created by Wanaldino Antimonio on 9/8/22.
//

import SwiftUI

struct PokedexList: View {
	@State var pokemons: [PokemonInfo]

    var body: some View {
		GeometryReader { proxy in
			ScrollView {
				let column = GridItem(.flexible())
				let columns = Array(repeating: column, count: 2)

				LazyVGrid(columns: columns, alignment: .leading, spacing: 8, content: {
					ForEach(pokemons) { pokemon in
						PokedexItemList(pokemon: pokemon)
					}
				})
				.padding(.all, 16)
				.background(Color.blue)
			}
		}
		.onAppear(perform: {
			Task {
				do {
					let response = try await HTTPClient().request(query: PokemonList())
					self.pokemons = response.pokemons
				} catch (let error) {
					print(error)
				}
			}
		})
    }
}

struct PokedexList_Previews: PreviewProvider {
    static var previews: some View {
		PokedexList(pokemons: PokemonInfo.mocks)
    }
}
