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

//	var query: String {
//		"""
//{
//  pokemons: pokemon_v2_pokemon(limit: 150) {
//	id
//	name
//	sprites: pokemon_v2_pokemonsprites {
//	  sprites
//	}
//	types: pokemon_v2_pokemontypes {
//	  type: pokemon_v2_type {
//		id
//		name
//	  }
//	}
//  }
//}
//"""
//	}
}
