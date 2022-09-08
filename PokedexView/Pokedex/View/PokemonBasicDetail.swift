//
//  PokemonBasicDetail.swift
//  Pokedex
//
//  Created by Wanaldino Antimonio on 11/8/22.
//

import SwiftUI
import PokedexAPI

struct PokemonBasicDetail: View {
	let pokemon: Pokemon
	
    var body: some View {
		Text(pokemon.name)
    }
}

struct PokemonBasicDetail_Previews: PreviewProvider {
    static var previews: some View {
		PokemonBasicDetail(pokemon: .mock)
    }
}
