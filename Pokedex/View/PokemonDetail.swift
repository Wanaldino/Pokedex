//
//  PokemonDetail.swift
//  Pokedex
//
//  Created by Wanaldino Antimonio on 11/8/22.
//

import SwiftUI

struct PokemonDetail: View {
	let pokemons: [PokemonInfo]
	@State var currentPokemon: PokemonInfo

    var body: some View {
		ZStack {
			TypeBackground(type: currentPokemon.types.first!)
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

				GeometryReader { proxy in
					TabView {
						ForEach(pokemons) { pokemon in
							AsyncImage(url: pokemon.sprite) { image in
								image.resizable()
									.aspectRatio(contentMode: .fit)
									.frame(width: proxy.size.width, height: proxy.size.height)
							} placeholder: {
								EmptyView()
							}
						}
					}.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
				}

				Spacer()
			}
			.foregroundColor(Color.white)
			.padding(.all, 16)
		}
    }
}

struct PokemonDetail_Previews: PreviewProvider {
    static var previews: some View {
		PokemonDetail(pokemons: PokemonInfo.mocks, currentPokemon: .mock)
    }
}
