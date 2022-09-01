//
//  Color+Ext.swift
//  Pokedex
//
//  Created by Wanaldino Antimonio on 9/8/22.
//

import SwiftUI

extension Color {
	enum Color: String {
		case red = "Rojo"
		case blue = "Azul"
		case yellow = "Amarillo"
		case green = "Verde"
	}

	init(_ color: Color) {
		self.init(color.rawValue)
	}
}