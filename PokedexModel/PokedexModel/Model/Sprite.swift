//
//  Pokemon+Sprite.swift
//  PokedexModel
//
//  Created by Wanaldino Antimonio on 21/9/22.
//

import Foundation

extension Pokemon {
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
}
