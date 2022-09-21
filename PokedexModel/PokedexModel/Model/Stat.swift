//
//  Stat.swift
//  PokedexModel
//
//  Created by Wanaldino Antimonio on 21/9/22.
//

import Foundation

extension Pokemon {
	public struct Stat: Decodable {
		let value: Int
		let info: Info

		init(value: Int, info: Pokemon.Stat.Info) {
			self.value = value
			self.info = info
		}
	}
}

extension Pokemon.Stat {
	public struct Info: Decodable {
		let id: Int
		let name: String

		enum CodingKeys: CodingKey {
			case id
			case name
		}

		init(id: Int, name: String) {
			self.id = id
			self.name = name
		}

		public init(from decoder: Decoder) throws {
			struct Name: Decodable {
				let name: String
			}

			let container: KeyedDecodingContainer<Pokemon.Stat.Info.CodingKeys> = try decoder.container(keyedBy: Pokemon.Stat.Info.CodingKeys.self)
			self.id = try container.decode(Int.self, forKey: Pokemon.Stat.Info.CodingKeys.id)

			let names = try container.decode([Name].self, forKey: Pokemon.Stat.Info.CodingKeys.name)
			self.name = names.first!.name
		}
	}
}
