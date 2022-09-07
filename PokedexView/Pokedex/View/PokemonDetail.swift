//
//  PokemonDetail.swift
//  Pokedex
//
//  Created by Wanaldino Antimonio on 11/8/22.
//

import SwiftUI
import PokedexAPI

struct PokemonDetail: View {
	static let padding = 16.0
	let pokemons: [PokemonInfo]

	@State var currentPokemon: PokemonInfo
	var index: Int { pokemons.firstIndex(of: currentPokemon)! }
	@State private var offset: CGFloat = 0
	@State private var isGestureActive: Bool = false

    @Namespace var animation
    @State var currentIndex: Int = 0

	func itemSize(in proxy: GeometryProxy) -> CGFloat {
		proxy.size.width * 0.5
	}

	var body: some View {
		ZStack {
			TypeBackground(type: currentPokemon.types.first!)
				.ignoresSafeArea(.all)

			VStack {
				InfoView()
				ChipsView()

				ZStack {
					PokeballView()
					PagerView()
					.padding(.horizontal, -Self.padding)
                }

				Spacer()

                VStack {
                    TabsView(currentPokemon: $currentPokemon, animation: animation)
                    Spacer()
                }
                .padding(.top, 50)
                .background {
                    Color.white
                        .cornerRadius(32, corners: [.topRight, .topLeft])
                        .padding(.horizontal, -Self.padding)
                        .ignoresSafeArea()
                }
			}
			.foregroundColor(Color.white)
			.padding(.horizontal, Self.padding)
        }
		.animation(Animation.easeIn, value: currentPokemon)
		.navigationBarTitleDisplayMode(.inline)
		.navigationBarBackButtonHidden(true)
    }


    // MARK: - Private
    @ViewBuilder
    private func InfoView() -> some View {
        HStack {
            Text(currentPokemon.name.capitalized)
                .font(.title)
                .fontWeight(.semibold)
            Spacer()
            Text(String(format: "#%03i", currentPokemon.id))
        }
    }

    @ViewBuilder
    private func ChipsView() -> some View {
        HStack {
            ForEach(currentPokemon.types) { type in
                TypeChip(type: type)
            }
            Spacer()
        }
    }

    @ViewBuilder
    private func PagerView() -> some View {
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
            .gesture(dragGesture(proxy: proxy))
        }
    }

    private func dragGesture(proxy: GeometryProxy) -> some Gesture {
        @GestureState var currentPokemon: PokemonInfo

        return DragGesture()
            .onChanged { value in
                isGestureActive = true
                offset = value.translation.width + -itemSize(in: proxy) * CGFloat(index)
            }

            .onEnded { value in
                if -value.translation.width > itemSize(in: proxy) / 2, index < pokemons.count - 1 {
                    self.currentPokemon = pokemons[index + 1]
                } else if value.translation.width > itemSize(in: proxy) / 2, index > 0 {
                    self.currentPokemon = pokemons[index - 1]
                }

                withAnimation {
                    isGestureActive = false
                }
            }
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
