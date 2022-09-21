//
//  Pokemon+mocks.swift
//  PokedexModel
//
//  Created by Wanaldino Antimonio on 21/9/22.
//

import Foundation

public extension Pokemon {
	static let mocks = [
		Pokemon(
			id: 1,
			name: "bulbasaur",
			height: 7,
			weight: 69,
			baseExperience: 64,
			sprite: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png")!,
			types: [PokemonType(
				id: 12,
				name: "grass"
			), PokemonType(
				id: 4,
				name: "poison"
			)],
			aditionalInfo: Pokemon.AditionalInfo(
				species: [
					AditionalInfo.Specie(name: "Seed Pokémon")
				],
				descriptions: [
					AditionalInfo.Description(description: "BULBASAUR can be seen napping in\nbright sunlight.\nThere is a seed on its back. By soaking up the sun’s rays, the seed\ngrows progressively larger.")
				],
				eggGroups: [
					AditionalInfo.EggGroup(group: AditionalInfo.EggGroup.Group(names: [
						AditionalInfo.EggGroup.Group.GroupInfo(name: "Monster")
					])),
					AditionalInfo.EggGroup(group: AditionalInfo.EggGroup.Group(names: [
						AditionalInfo.EggGroup.Group.GroupInfo(name: "Grass")
					])
					)
				],
				gender_rate: 1
			),
			stats: [
				Stat(
					value: 45,
					info: Stat.Info(
						id: 1,
						name: "HP"
					)
				),
				Stat(
					value: 49,
					info: Stat.Info(
						id: 2,
						name: "Attack"
					)
				),
				Stat(
					value: 49,
					info: Stat.Info(
						id: 3,
						name: "Defense"
					)
				),
				Stat(
					value: 65,
					info: Stat.Info(
						id: 4,
						name: "Special Attack"
					)
				),
				Stat(
					value: 65,
					info: Stat.Info(
						id: 5,
						name: "Special Defense"
					)
				),
				Stat(
					value: 45,
					info: Stat.Info(
						id: 6,
						name: "Speed"
					)
				)
			]
		),
		Pokemon(
			id: 4,
			name: "charmander",
			height: 6,
			weight: 85,
			baseExperience: 62,
			sprite: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png")!,
			types: [PokemonType(
				id: 10,
				name: "fire"
			)],
			aditionalInfo: Pokemon.AditionalInfo(
				species: [
					AditionalInfo.Specie(name: "Lizard Pokémon")
				],
				descriptions: [
					AditionalInfo.Description(description: "The flame that burns at the tip of its\ntail is an indication of its emotions.\nThe flame wavers when CHARMANDER is enjoying itself. If the POKéMON becomes\nenraged, the flame burns fiercely.")
				],
				eggGroups: [
					AditionalInfo.EggGroup(group: AditionalInfo.EggGroup.Group(names: [
						AditionalInfo.EggGroup.Group.GroupInfo(name: "Monster")
					])),
					AditionalInfo.EggGroup(group: AditionalInfo.EggGroup.Group(names: [
						AditionalInfo.EggGroup.Group.GroupInfo(name: "Dragon")
					]))
				],
				gender_rate: 1
			),
			stats: [
				Stat(
					value: 39,
					info: Stat.Info(
						id: 1,
						name: "HP"
					)
				),
				Stat(
					value: 52,
					info: Stat.Info(
						id: 2,
						name: "Attack"
					)
				),
				Stat(
					value: 43,
					info: Stat.Info(
						id: 3,
						name: "Defense"
					)
				),
				Stat(
					value: 60,
					info: Stat.Info(
						id: 4,
						name: "Special Attack"
					)
				),
				Stat(
					value: 50,
					info: Stat.Info(
						id: 5,
						name: "Special Defense"
					)
				),
				Stat(
					value: 65,
					info: Stat.Info(
						id: 6,
						name: "Speed"
					)
				)
			]
		),
		Pokemon(
			id: 7,
			name: "squirtle",
			height: 5,
			weight: 90,
			baseExperience: 63,
			sprite: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/7.png")!,
			types: [PokemonType(
				id: 11,
				name: "water"
			)],
			aditionalInfo: Pokemon.AditionalInfo(
				species: [
					AditionalInfo.Specie(name: "Tiny Turtle Pokémon")
				],
				descriptions: [
					AditionalInfo.Description(description: "SQUIRTLE’s shell is not merely used\nfor protection.\nThe shell’s rounded shape and the grooves on its surface help minimize\nresistance in water, enabling this\nPOKéMON to swim at high speeds.")
				],
				eggGroups: [
					AditionalInfo.EggGroup(group: AditionalInfo.EggGroup.Group(names: [
						AditionalInfo.EggGroup.Group.GroupInfo(name: "Monster")
					])),
					AditionalInfo.EggGroup(group: AditionalInfo.EggGroup.Group(names: [
						AditionalInfo.EggGroup.Group.GroupInfo(name: "Water 1")
					]))
				],
				gender_rate: 1
			),
			stats: [
				Stat(
					value: 44,
					info: Stat.Info(
						id: 1,
						name: "HP"
					)
				),
				Stat(
					value: 48,
					info: Stat.Info(
						id: 2,
						name: "Attack"
					)
				),
				Stat(
					value: 65,
					info: Stat.Info(
						id: 3,
						name: "Defense"
					)
				),
				Stat(
					value: 50,
					info: Stat.Info(
						id: 4,
						name: "Special Attack"
					)
				),
				Stat(
					value: 64,
					info: Stat.Info(
						id: 5,
						name: "Special Defense"
					)
				),
				Stat(
					value: 43,
					info: Stat.Info(
						id: 6,
						name: "Speed"
					)
				)
			]
		),
		Pokemon(
			id: 25,
			name: "pikachu",
			height: 4,
			weight: 60,
			baseExperience: 112,
			sprite: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png")!,
			types: [.mock],
			aditionalInfo: Pokemon.AditionalInfo(
				species: [
					AditionalInfo.Specie(name: "Mouse Pokémon")
				],
				descriptions: [
					AditionalInfo.Description(description: "This POKéMON has electricity-storing\npouches on its cheeks. These appear to\nbecome electrically charged during the night while PIKACHU sleeps.\nIt occasionally discharges electricity\nwhen it is dozy after waking up.")
				],
				eggGroups: [
					AditionalInfo.EggGroup(group: AditionalInfo.EggGroup.Group(names: [
						AditionalInfo.EggGroup.Group.GroupInfo(name: "Field")
					])),
					AditionalInfo.EggGroup(group: AditionalInfo.EggGroup.Group(names: [
						AditionalInfo.EggGroup.Group.GroupInfo(name: "Fairy")
					]))
				],
				gender_rate: 4
			),
			stats: [
				Stat(
					value: 35,
					info: Stat.Info(
						id: 1,
						name: "HP"
					)
				),
				Stat(
					value: 55,
					info: Stat.Info(
						id: 2,
						name: "Attack"
					)
				),
				Stat(
					value: 40,
					info: Stat.Info(
						id: 3,
						name: "Defense"
					)
				),
				Stat(
					value: 50,
					info: Stat.Info(
						id: 4,
						name: "Special Attack"
					)
				),
				Stat(
					value: 50,
					info: Stat.Info(
						id: 5,
						name: "Special Defense"
					)
				),
				Stat(
					value: 90,
					info: Stat.Info(
						id: 6,
						name: "Speed"
					)
				)
			]
		)
	]
	static let mock = mocks.first!
}
