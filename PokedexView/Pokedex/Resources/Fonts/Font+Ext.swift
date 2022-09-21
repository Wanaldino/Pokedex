//
//  Font+Ext.swift
//  Pokedex
//
//  Created by Wanaldino Antimonio on 19/9/22.
//

import SwiftUI

extension Font {
	static func black(size: CGFloat) -> Font {
		.custom("CircularStd-Black", size: size)
	}

	static func bold(size: CGFloat = 32) -> Font {
		.custom("CircularStd-Bold", size: size)
	}

	static func book(size: CGFloat) -> Font {
		.custom("CircularStd-Book", size: size)
	}

	static func medium(size: CGFloat = 16) -> Font {
		.custom("CircularStd-Medium", size: size)
	}
}
