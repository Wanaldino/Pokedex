//
//  PokemonDetail.swift
//  Pokedex
//
//  Created by Wanaldino Antimonio on 11/8/22.
//

import SwiftUI
import PokedexModel

struct PokemonDetail: View {
	static let padding = 16.0
	let pokemons: [Pokemon]

	@State var currentPokemon: Pokemon
	var index: Int { pokemons.firstIndex(of: currentPokemon)! }
	@State private var offset: CGFloat = 0
	@State private var isGestureActive: Bool = false

    @State private var startOffsetY: CGFloat = UIScreen.main.bounds.height * 0.5
    @State private var currentDragOffsetY: CGFloat = 0
    @State private var endDragOffsetY: CGFloat = 0

    @Namespace var animation

	func itemSize(in proxy: GeometryProxy) -> CGFloat {
		proxy.size.width * 0.5
	}

	var body: some View {
        ZStack {
            TypeBackground(type: currentPokemon.types.first!)
                .ignoresSafeArea(.all)
            GeometryReader { proxy in
                VStack(spacing: 8) {
                    VStack {
                        InfoView()
                        ChipsView()
                    }
                    .padding()

                    ZStack {
                        PokeballView()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(width: proxy.size.width * 0.45)
                            .padding(.top)

                        PagerView()
                            .frame(height: itemSize(in: proxy))
                    }

                }
            }

            TabsView(currentPokemon: $currentPokemon, animation: animation)
                .padding()
                .background {
                    Color.white
                        .cornerRadius(32, corners: [.topRight, .topLeft])
                        .padding(.horizontal)
                }
                .offset(y: startOffsetY)
                .offset(y: currentDragOffsetY)
                .offset(y: endDragOffsetY)
                .padding(.horizontal, -Self.padding)
                .gesture(DragGesture()
                    .onChanged { value in
                        withAnimation(.spring()) {
                            currentDragOffsetY = value.translation.height
                        }
                    }
                    .onEnded { value in
                        withAnimation(.spring()) {
                            if currentDragOffsetY < -150 {
                                endDragOffsetY = -startOffsetY
                            } else if endDragOffsetY != 0 && currentDragOffsetY > 150 {
                                endDragOffsetY = 0
                            }
                            currentDragOffsetY = 0
                        }
                    }
                )
                .ignoresSafeArea(edges: .bottom)
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
                        CacheAsyncImage(url: pokemon.sprite!) { phase in
                            switch phase {
                            case .success(let image):
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
                            case .failure:
                                Spacer().frame(width: itemSize(in: proxy))
                            case .empty:
                                ProgressView().progressViewStyle(CircularProgressViewStyle())
                            @unknown default:
                                EmptyView()
                            }
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
        DragGesture()
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
		PokemonDetail(pokemons: Pokemon.mocks, currentPokemon: .mock)
		PokemonDetail(pokemons: Pokemon.mocks, currentPokemon: .mock)
			.previewDevice("iPad Air (5th generation)")
			.previewLayout(.device)
	}
}
