//
//  PokedexItemList.swift
//  Pokedex
//
//  Created by Wanaldino Antimonio on 9/8/22.
//

import SwiftUI
import PokedexModel

struct PokedexItemList: View {
	let pokemon: Pokemon

    var body: some View {
		GeometryReader { proxy in
			ZStack {
				TypeBackground(type: pokemon.types.first!)

				HStack {
					VStack(alignment: .leading, spacing: 8) {
						Text(pokemon.name.capitalized)
							.font(.headline)
							.fontWeight(.bold)
						ForEach(pokemon.types, id: \.id) { type in
							TypeChip(type: type)
						}
						Spacer()
					}.foregroundColor(Color.white)
					Spacer()
				}.padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))

				VStack {
					Spacer()

                    ZStack(alignment: .bottomTrailing) {
                        PokeballView(shouldAnimate: false)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: proxy.size.width * 0.40)
                            .padding(.bottom, -12)
                            .padding(.trailing, -12)

                        HStack {
                            Spacer()
                            CacheAsyncImage(url: pokemon.sprite!) { phase in
                                switch phase {
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: proxy.size.height * 0.7)
                                case .failure:
                                    EmptyView()
                                case .empty:
                                    HStack {
                                        ProgressView().progressViewStyle(CircularProgressViewStyle())
                                    }
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        }
                        .padding(.bottom, 10)
                        .padding(.trailing, 10)
                    }
				}
			}
			.cornerRadius(20)
		}
    }
}

struct PokedexItemList_Previews: PreviewProvider {
    static var previews: some View {
		PokedexItemList(pokemon: .mock)
			.frame(width: 300, height: 160)
    }
}
