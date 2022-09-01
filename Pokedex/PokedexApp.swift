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
	@State private var path = NavigationPath()

    var body: some Scene {
        WindowGroup {
			NavigationStack(path: $path) {
				PokedexList(pokemons: [])
					.navigationDestination(for: Screen.self, destination: { screen in
						switch screen {
						case let .detail(pokemons, pokemon):
							PokemonDetail(pokemons: pokemons, currentPokemon: pokemon)
								.toolbar {
									ToolbarItem(placement: .navigationBarLeading) {
										Image(systemName: "chevron.left")
											.foregroundColor(.white)
											.onTapGesture {
												path.removeLast()
											}
									}
								}
						}
					})
			}
			.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
