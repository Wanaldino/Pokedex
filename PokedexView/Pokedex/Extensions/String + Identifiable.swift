//
//  String + Identifiable.swift
//  Pokedex
//
//  Created by Wanaldino Antimonio on 9/9/22.
//

import Foundation

extension String: Identifiable {
	public var id: Int {
		hashValue
	}
}
