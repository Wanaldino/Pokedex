//
//  PokemonBasicDetail.swift
//  Pokedex
//
//  Created by Wanaldino Antimonio on 11/8/22.
//

import SwiftUI

struct PokemonBasicDetail: View {
	let pokemon: PokemonInfo
	
    var body: some View {
		Text(pokemon.name)
    }
}

struct PokemonBasicDetail_Previews: PreviewProvider {
    static var previews: some View {
		PokemonBasicDetail(pokemon: .mock)
    }
}
