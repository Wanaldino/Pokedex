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
	var index: Int { pokemons.firstIndex(of: currentPokemon)! }
	@State private var offset: CGFloat = 0
	@State private var isGestureActive: Bool = false

	func itemSize(in proxy: GeometryProxy) -> CGFloat {
		proxy.size.width * 0.5
	}

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
					//					Text("Seed Pokemon")
				}

				ZStack {
					PokeballView()
					GeometryReader { proxy in
						ScrollView(.horizontal, showsIndicators: false) {
							LazyHStack(alignment: .center, spacing: 0) {
								Spacer().frame(width: itemSize(in: proxy) * 0.5)
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
											.frame(width: itemSize(in: proxy))
											.scaleEffect(currentPokemon == pokemon ? 1 : 0.5)

									} placeholder: {
										EmptyView()
									}
								}
								Spacer().frame(width: itemSize(in: proxy) * 0.5)
							}
						}
						.content.offset(x: isGestureActive ? offset : -itemSize(in: proxy) * CGFloat(index))
						.contentShape(Rectangle())
						.gesture(DragGesture().onChanged({ value in
							isGestureActive = true
							offset = value.translation.width + -itemSize(in: proxy) * CGFloat(index)
						}).onEnded({ value in
							if -value.translation.width > itemSize(in: proxy) / 2, index < pokemons.count - 1 {
								currentPokemon = pokemons[index + 1]
							} else if value.translation.width > itemSize(in: proxy) / 2, index > 0 {
								currentPokemon = pokemons[index - 1]
							}

							withAnimation {
								isGestureActive = false
							}
						}))
					}
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
		PokemonDetail(pokemons: PokemonInfo.mocks, currentPokemon: .mock)
			.previewDevice("iPad Air (5th generation)")
			.previewLayout(.device)
	}
}
