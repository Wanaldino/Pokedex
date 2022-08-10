//
//  PokemonInfo.swift
//  Pokedex
//
//  Created by Wanaldino Antimonio on 9/8/22.
//

import Foundation

struct PokemonInfo: Decodable {
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
	
	let id: Int
	let name: String
	let sprite: URL?
	let types: [PokemonType]

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

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.id = try container.decode(Int.self, forKey: .id)
		self.name = try container.decode(String.self, forKey: .name)

		let spritesData = try container.decode([Sprite].self, forKey: .sprites).first!.sprites.data(using: .utf8)!
		let sprites = try? JSONDecoder().decode(_Sprite.self, from: spritesData)
		//sprites?["other"]["dream_world"]["home"]["official-artwork"]["front_default"]
		self.sprite = sprites?.sprite.sprite.sprite
		self.types = try container.decode([_Type].self, forKey: .types).compactMap({ $0.type })
	}
}

extension PokemonInfo: Identifiable {}

extension PokemonInfo {
	static let mocks = [
		PokemonInfo(
			id: 25,
			name: "pikachu",
			sprite: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png")!,
			types: [.mock]
		),
		PokemonInfo(
			id: 26,
			name: "pikachu",
			sprite: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png")!,
			types: [.mock]
		),
		PokemonInfo(
			id: 27,
			name: "pikachu",
			sprite: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png")!,
			types: [.mock]
		),
		PokemonInfo(
			id: 28,
			name: "pikachu",
			sprite: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png")!,
			types: [.mock]
		)
	]
	static let mock = mocks.first!
}
