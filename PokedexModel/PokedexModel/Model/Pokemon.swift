//
//  PokemonInfo.swift
//  Pokedex
//
//  Created by Wanaldino Antimonio on 9/8/22.
//

import Foundation

public struct Pokemon: Decodable, Hashable, Identifiable {
	public let id: Int
	public let name: String
	public let height: Int
	public let weight: Int
	public let baseExperience: Int
	public let sprite: URL?
	public let types: [PokemonType]
	public let aditionalInfo: AditionalInfo
	public let stats: [Stat]

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
		case stats
	}

	init(id: Int, name: String, height: Int, weight: Int, baseExperience: Int, sprite: URL? = nil, types: [PokemonType], aditionalInfo: AditionalInfo, stats: [Stat]) {
		self.id = id
		self.name = name
		self.height = height
		self.weight = weight
		self.baseExperience = baseExperience
		self.sprite = sprite
		self.types = types
		self.aditionalInfo = aditionalInfo
		self.stats = stats
	}

	public init(from decoder: Decoder) throws {
		struct _Type: Decodable {
			let type: PokemonType
		}

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
		self.stats = try container.decode([Stat].self, forKey: .stats)
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
