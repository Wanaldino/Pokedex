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
	
	public let id: Int
	public let name: String
	public let sprite: URL?
	public let types: [PokemonType]

	enum CodingKeys: CodingKey {
		case id
		case name
		case sprites
		case types
	}

	init(id: Int, name: String, sprite: URL? = nil, types: [PokemonType]) {
		self.id = id
		self.name = name
		self.sprite = sprite
		self.types = types
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.id = try container.decode(Int.self, forKey: .id)
		self.name = try container.decode(String.self, forKey: .name)

		let spritesData = try container.decode([Sprite].self, forKey: .sprites).first!.sprites.data(using: .utf8)!
		let sprites = try? JSONDecoder().decode(_Sprite.self, from: spritesData)
		self.sprite = sprites?.sprite.sprite.sprite
		self.types = try container.decode([_Type].self, forKey: .types).compactMap({ $0.type })
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
			sprite: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png")!,
			types: [PokemonType(
				id: 12,
				name: "grass"
			), PokemonType(
				id: 4,
				name: "poison"
			)]
		),
		Pokemon(
			id: 4,
			name: "charmander",
			sprite: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png")!,
			types: [PokemonType(
				id: 10,
				name: "fire"
			)]
		),
		Pokemon(
			id: 7,
			name: "squirtle",
			sprite: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/7.png")!,
			types: [PokemonType(
				id: 11,
				name: "water"
			)]
		),
		Pokemon(
			id: 25,
			name: "pikachu",
			sprite: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png")!,
			types: [.mock]
		)
	]
	static let mock = mocks.first!
}
