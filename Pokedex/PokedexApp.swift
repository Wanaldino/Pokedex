//
//  PokedexApp.swift
//  Pokedex
//
//  Created by Wanaldino Antimonio on 9/8/22.
//

import SwiftUI

@main
struct PokedexApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
			NavigationStack {
				PokedexList(pokemons: [])
					.navigationDestination(for: Screen.self, destination: { screen in
						switch screen {
						case let .detail(pokemons, pokemon):
							PokemonDetail(pokemons: pokemons, currentPokemon: pokemon)
						}
					})
			}
			.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
