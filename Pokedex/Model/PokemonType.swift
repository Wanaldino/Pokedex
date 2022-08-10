//
//  Type.swift
//  Pokedex
//
//  Created by Wanaldino Antimonio on 9/8/22.
//

import Foundation

struct PokemonType: Decodable {
	enum _Type: String {
		case normal, fire, water, grass, electric, ice, fighing, poison, ground, flying, psychic, bug, rock, ghost, dark, dragon, steel, fairy
	}

	static let mock = PokemonType(id: 13, name: "electric")
	let id: Int
	let name: String

	var type: _Type? {
		_Type(rawValue: name)
	}
}
