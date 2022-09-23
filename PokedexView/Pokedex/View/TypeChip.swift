//
//  TypeChip.swift
//  Pokedex
//
//  Created by Wanaldino Antimonio on 9/8/22.
//

import SwiftUI
import PokedexModel

struct TypeChip: View {
	let type: PokemonType
    var body: some View {
		Text(type.name.capitalized)
			.font(.medium())
			.padding(.horizontal, 10)
			.padding(.vertical, 4)
			.background(
				GeometryReader { proxy in
					ZStack {
						Color.white
						type.color
							.opacity(0.7)
					}
					.cornerRadius(proxy.size.height / 2)
				}
			)

    }
}

struct TypeChip_Previews: PreviewProvider {
    static var previews: some View {
		ZStack(alignment: .center) {
			PokemonType.mock.color
			TypeChip(type: .mock)
		}
    }
}
