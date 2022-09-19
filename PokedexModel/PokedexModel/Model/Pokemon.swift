//
//  PokemonInfo.swift
//  Pokedex
//
//  Created by Wanaldino Antimonio on 9/8/22.
//

import Foundation

public struct Pokemon: Decodable, Hashable, Identifiable {
	struct _Sprite: Decodable {
		struct Sprite: Decodable {
			struct Sprite: Decodable {
				let sprite: URL?
				enum CodingKeys: String, CodingKey {
					case sprite = "front_default"
				}
			}
			let sprite: Sprite
			enum CodingKeys: String, CodingKey {
				case sprite = "official-artwork"
			}
		}
		let sprite: Sprite
		enum CodingKeys: String, CodingKey {
			case sprite = "other"
		}
	}
	struct Sprite: Decodable {
		let sprites: String
		enum CodingKeys: String, CodingKey {
			case sprites
		}
	}
	struct _Type: Decodable {
		let type: PokemonType
	}
	public struct AditionalInfo: Decodable {
		public struct Specie: Decodable {
			public let name: String
		}
		public struct Description: Decodable {
			public let description: String
		}
		public struct EggGroup: Decodable {
			public struct Group: Decodable {
				public struct GroupInfo: Decodable {
					public let name: String
				}
				public let names: [GroupInfo]
			}
			public let group: Group
		}
		public enum Gender: Hashable {
			case male(Double)
			case female(Double)
			case genderless

			public var rate: Double {
				switch self {
				case .male(let rate): return rate
				case .female(let rate): return rate
				case .genderless: return 1
				}
			}

			public var image: String? {
				switch self {
				case .female: return "female_sign"
				case .male: return "male_sign"
				case .genderless: return nil
				}
			}
		}

		public let species: [Specie]
		public let descriptions: [Description]
		public let eggGroups: [EggGroup]

		let gender_rate: Int
		public var genders: [Gender] {
			guard gender_rate != -1 else { return [.genderless] }

			var female: Gender?
			let femaleRatio = Double(gender_rate) / 8
			if femaleRatio > 0 {
				female = .female(femaleRatio)
			}

			var male: Gender?
			let maleRatio = 1 - femaleRatio
			if maleRatio > 0 {
				male = .male(maleRatio)
			}

			return [male, female].compactMap({ $0 })
		}
	}
	
	public let id: Int
	public let name: String
	public let height: Int
	public let weight: Int
	public let baseExperience: Int
	public let sprite: URL?
	public let types: [PokemonType]
	public let aditionalInfo: AditionalInfo

	public var description: String? {
		aditionalInfo.descriptions
			.map(\.description)
			.sorted(by: { $0.description.count > $1.description.count })
			.first?
			.replacingOccurrences(of: name.uppercased(), with: name.capitalized)
			.replacingOccurrences(of: "\n", with: " ")
	}

	enum CodingKeys: CodingKey {
		case id
		case name
		case height
		case weight
		case baseExperience
		case sprites
		case types
		case aditionalInfo
	}

	init(id: Int, name: String, height: Int, weight: Int, baseExperience: Int, sprite: URL? = nil, types: [PokemonType], aditionalInfo: AditionalInfo) {
		self.id = id
		self.name = name
		self.height = height
		self.weight = weight
		self.baseExperience = baseExperience
		self.sprite = sprite
		self.types = types
		self.aditionalInfo = aditionalInfo
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.id = try container.decode(Int.self, forKey: .id)
		self.name = try container.decode(String.self, forKey: .name)
		self.height = try container.decode(Int.self, forKey: .height)
		self.weight = try container.decode(Int.self, forKey: .weight)
		self.baseExperience = try container.decode(Int.self, forKey: .baseExperience)

		let spritesData = try container.decode([Sprite].self, forKey: .sprites).first!.sprites.data(using: .utf8)!
		let sprites = try? JSONDecoder().decode(_Sprite.self, from: spritesData)
		self.sprite = sprites?.sprite.sprite.sprite
		self.types = try container.decode([_Type].self, forKey: .types).compactMap({ $0.type })
		self.aditionalInfo = try container.decode(AditionalInfo.self, forKey: .aditionalInfo)
	}
}

public extension Pokemon { //Hashable
	static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
		lhs.id == rhs.id
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
}

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
			)
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
			)
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
			)
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
			)
		)
	]
	static let mock = mocks.first!
}
