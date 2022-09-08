//
//  PokemonList.swift
//  Pokedex
//
//  Created by Wanaldino Antimonio on 9/8/22.
//

import Foundation
import PokedexModel

public struct PokemonList: Query {
	public typealias Variables = VoidVariables

	public struct Response: Decodable {
		public let pokemons: [Pokemon]
	}

	public init() {}
}
