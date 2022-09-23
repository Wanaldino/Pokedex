//
//  TypeEffectivity.swift
//  PokedexModel
//
//  Created by Wanaldino Antimonio on 22/9/22.
//

import Foundation

public struct TypeEffectivity: Decodable {
	public let attackerID: Int
	public let defenerID: Int
	let effectivity: Int
	public var value: Double { Double(effectivity) / 100 }
}
