//
//  Effectivity.swift
//  Pokedex
//
//  Created by Wanaldino Antimonio on 22/9/22.
//

import SwiftUI
import PokedexModel

struct Effectivity: View {
	@State var effectivity: TypeManager.MixedEffectivity
	@State var type: PokemonType?

    var body: some View {
		if let type {
			Text(String(format: "%@ x%1g", type.name.capitalized, effectivity.value))
				.font(.medium())
				.foregroundColor(type.color)
				.padding(.horizontal, 10)
				.padding(.vertical, 4)
				.background(
					GeometryReader { proxy in
						ZStack {
							Color.white
							type.color
								.opacity(0.3)
						}
						.cornerRadius(proxy.size.height / 2)
					}
				)
		} else {
			Spacer()
				.task {
					type = await TypeManager.shared.type(with: effectivity.targetType)
				}
		}
    }
}

struct Effectivity_Previews: PreviewProvider {
    static var previews: some View {
        Effectivity(effectivity: TypeManager.MixedEffectivity(targetType: 1, value: 1))
    }
}
