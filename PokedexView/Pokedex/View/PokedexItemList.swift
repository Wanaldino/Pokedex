//
//  PokedexItemList.swift
//  Pokedex
//
//  Created by Wanaldino Antimonio on 9/8/22.
//

import SwiftUI
import PokedexAPI

struct PokedexItemList: View {
	let pokemon: PokemonInfo

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
					HStack {
						Spacer()
						AsyncImage(url: pokemon.sprite, content: { image in
							image
								.resizable()
								.aspectRatio(contentMode: .fit)
								.frame(height: proxy.size.height * 0.5)
						}, placeholder: {
							EmptyView()
						})
					}.padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
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
