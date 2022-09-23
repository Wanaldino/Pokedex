//
//  TypeList.swift
//  PokedexAPI
//
//  Created by Wanaldino Antimonio on 22/9/22.
//

import Foundation
import PokedexModel

public struct TypeList: Query {
	public typealias Variables = VoidVariables

	public struct Response: Decodable {
		public let types: [PokemonType]
	}

	public init() {}
}
