//
//  TypeChart.swift
//  PokedexAPI
//
//  Created by Wanaldino Antimonio on 22/9/22.
//

import Foundation
import PokedexModel

public struct TypeChart: Query {
	public typealias Variables = VoidVariables

	public struct Response: Decodable {
		public let effectivities: [TypeEffectivity]
	}

	public init() {}
}
