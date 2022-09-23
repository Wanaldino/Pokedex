//
//  PokemonType+color.swift
//  Pokedex
//
//  Created by Wanaldino Antimonio on 22/9/22.
//

import Foundation
import SwiftUI
import PokedexModel

extension PokemonType {
	var color: Color {
		switch type {
		case .normal: return Color(.normal)
		case .fire: return Color(.fire)
		case .water: return Color(.water)
		case .grass: return Color(.grass)
		case .electric: return Color(.electric)
		case .ice: return Color(.ice)
		case .fighting: return Color(.figthing)
		case .poison: return Color(.poison)
		case .ground: return Color(.ground)
		case .flying: return Color(.flying)
		case .psychic: return Color(.psychic)
		case .bug: return Color(.bug)
		case .rock: return Color(.rock)
		case .ghost: return Color(.ghost)
		case .dark: return Color(.dark)
		case .dragon: return Color(.dragon)
		case .steel: return Color(.steel)
		case .fairy: return Color(.fairy)
		default: return Color.white
		}
	}
}
