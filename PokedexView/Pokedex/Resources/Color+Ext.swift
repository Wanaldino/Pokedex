//
//  Color+Ext.swift
//  Pokedex
//
//  Created by Wanaldino Antimonio on 9/8/22.
//

import SwiftUI

extension Color {
	enum Color: String {
		case fire = "Fire"
		case water = "Water"
		case electric = "Electric"
		case grass = "Grass"
		case bug = "Bug"
		case ice = "Ice"
		case normal = "Normal"
		case poison = "Poison"
		case ground = "Ground"
		case fairy = "Fairy"
		case psychic = "Psychic"
		case dragon = "Dragon"
		case rock = "Rock"
		case figthing = "Fighting"
		case flying = "Flying"
		case ghost = "Ghost"
		case dark = "Dark"
		case steel = "Steel"

		case male = "Male"
		case female = "Female"
		case genderless = "Genderless"
	}

	init(_ color: Color) {
		self.init(color.rawValue)
	}
}
