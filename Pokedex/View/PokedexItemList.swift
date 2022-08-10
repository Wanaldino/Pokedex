//
//  PokedexItemList.swift
//  Pokedex
//
//  Created by Wanaldino Antimonio on 9/8/22.
//

import SwiftUI

struct PokedexItemList: View {
	let pokemon: PokemonInfo

    var body: some View {
		GeometryReader { proxy in
			ZStack(alignment: .bottomTrailing) {
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

				HStack {
					Spacer()
					AsyncImage(url: pokemon.sprite, content: { image in
						image.resizable().frame(width: proxy.size.height / 2, height: proxy.size.height / 2)
					}, placeholder: {
						EmptyView()
					})
				}.padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
			}
			.frame(height: proxy.size.width * 0.8)
			.cornerRadius(20)
		}
    }
}

struct PokedexItemList_Previews: PreviewProvider {
    static var previews: some View {
		PokedexItemList(pokemon: .mock)
			.previewLayout(.sizeThatFits)
//			.frame(width: 300, height: 150)
    }
}
