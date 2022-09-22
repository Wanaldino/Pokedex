//
//  Type.swift
//  Pokedex
//
//  Created by Wanaldino Antimonio on 9/8/22.
//

import Foundation

public struct PokemonType: Decodable, Identifiable {
	public enum _Type: String {
		case normal, fire, water, grass, electric, ice, fighing, poison, ground, flying, psychic, bug, rock, ghost, dark, dragon, steel, fairy
	}

	public let id: Int
	public let name: String
	public var type: _Type? { _Type(rawValue: name) }

	public init(id: Int, name: String) {
		self.id = id
		self.name = name
	}
}

public extension PokemonType {
	static let mock = PokemonType(id: 13, name: "electric")
}
