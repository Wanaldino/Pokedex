//
//  PokemonBackground.swift
//  Pokedex
//
//  Created by Wanaldino Antimonio on 9/8/22.
//

import SwiftUI
import PokedexAPI

struct TypeBackground: View {
	let type: PokemonType
    var body: some View {
		switch type.type {
		case .normal: Color.gray
		case .fire: Color(.red)
		case .water: Color(.blue)
		case .grass: Color(.green)
		case .electric: Color(.yellow)
		case .ice: Color.cyan
		case .fighing: Color.red
		case .poison: Color.purple
		case .ground: Color.yellow
		case .flying: Color.purple
		case .psychic: Color.pink
		case .bug: Color.green
		case .rock: Color.gray
		case .ghost: Color.indigo
		case .dark: Color.black
		case .dragon: Color.indigo
		case .steel: Color.gray
		case .fairy: Color.pink
		default: Color.white
		}
    }
}

struct TypeBackground_Previews: PreviewProvider {
    static var previews: some View {
		TypeBackground(type: .mock)
		TypeBackground(type: .init(id: 0, name: "fire"))
    }
}
