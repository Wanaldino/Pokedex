//
//  PokemonBasicDetail.swift
//  Pokedex
//
//  Created by Wanaldino Antimonio on 11/8/22.
//

import SwiftUI
import PokedexModel

struct PokemonBasicDetail: View {
	let pokemon: Pokemon
	
    var body: some View {
		GeometryReader { proxy in
			VStack(spacing: 16) {
				if let description = pokemon.description {
					Text(description)
				}

                let padding = 16.0
				let availableWidth = proxy.size.width - 2 * padding

				HStack(spacing: 0) {
					VerticalDescription(title: "Height", description: pokemon.height.description)
						.frame(minWidth: availableWidth / 2, alignment: .leading)
					VerticalDescription(title: "Weight", description: pokemon.weight.description)
						.frame(minWidth: availableWidth / 2, alignment: .leading)
				}
				.padding(.horizontal, padding)
				.padding(.vertical, padding)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .cornerRadius(10)
                        .shadow(
                            color: Color.gray.opacity(0.4),
                            radius: 10,
                            x: 0,
                            y: 8
                        )
                }

                VStack(alignment: .leading) {
                    Text("Breeding")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.top)
                        .padding(.bottom)
                    let maxWidth = proxy.size.width / 3
                    let columns = [GridItem(.flexible(minimum: 0, maximum: maxWidth)), GridItem()]
                    LazyVGrid(columns: columns, alignment: .leading, spacing: 10) {
                        Text("Gender")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.gray)
                        Text("\(pokemon.aditionalInfo.gender_rate)")
                        Text("Egg group")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.gray)
                        Text("\(pokemon.aditionalInfo.eggGroups.compactMap { $0.group.names.compactMap { $0.name }.first }.first ?? "")")
                        Text("Egg cycle")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.gray)
                        Text("\(pokemon.aditionalInfo.eggGroups.compactMap { $0.group.names.compactMap { $0.name }.first }.last ?? "")")
                    }
                }
			}
		}
		.padding(.horizontal, 20)
    }

	@ViewBuilder
	func VerticalDescription(title: String, description: String) -> some View {
		VStack(alignment: .leading) {
			Text(title)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(Color.gray)
			Text(description)
		}
	}
}

struct PokemonBasicDetail_Previews: PreviewProvider {
    static var previews: some View {
		PokemonBasicDetail(pokemon: .mock)
    }
}
