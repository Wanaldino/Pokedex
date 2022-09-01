//
//  PokemonList.swift
//  Pokedex
//
//  Created by Wanaldino Antimonio on 9/8/22.
//

import Foundation

struct PokemonList: Query {
	typealias Variables = VoidVariables

	struct Response: Decodable {
		let pokemons: [PokemonInfo]
	}
}
