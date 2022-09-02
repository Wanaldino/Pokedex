//
//  PokemonDetail.swift
//  Pokedex
//
//  Created by Wanaldino Antimonio on 11/8/22.
//

import SwiftUI

struct PokemonDetail: View {
	static let padding = 16.0
	let pokemons: [PokemonInfo]

	@State var currentPokemon: PokemonInfo

    var body: some View {
		ZStack {
			TypeBackground(type: currentPokemon.types.first!)
				.ignoresSafeArea(.all)

			VStack {
				HStack {
					Text(currentPokemon.name.capitalized)
						.font(.title)
						.fontWeight(.semibold)
					Spacer()
					Text(String(format: "#%03i", currentPokemon.id))
				}

				HStack {
					ForEach(currentPokemon.types) { type in
						TypeChip(type: type)
					}
					Spacer()
					Text("Seed Pokemon")
				}

				ZStack {
					PokeballView()
					TabView(selection: $currentPokemon) {
						ForEach(pokemons) { pokemon in
							AsyncImage(url: pokemon.sprite) { image in
								image.resizable()
									.aspectRatio(contentMode: .fit)
									.overlay(content: {
										image.resizable()
											.renderingMode(.template)
											.foregroundColor(.black)
											.aspectRatio(contentMode: .fit)
											.opacity(currentPokemon == pokemon ? 0 : 1)
									})
									.scaleEffect(currentPokemon == pokemon ? 1 : 0.5)

							} placeholder: {
								EmptyView()
							}
							.tag(pokemon)
						}
					}
					.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
					.padding(.horizontal, -Self.padding)
				}

				Spacer()
			}
			.foregroundColor(Color.white)
			.padding(.horizontal, Self.padding)
		}
		.animation(Animation.easeIn, value: currentPokemon)
		.navigationBarTitleDisplayMode(.inline)
		.navigationBarBackButtonHidden(true)
    }
}

struct PokemonDetail_Previews: PreviewProvider {
    static var previews: some View {
		PokemonDetail(pokemons: PokemonInfo.mocks, currentPokemon: .mock)
    }
}
