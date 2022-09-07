//
//  CGRect + center.swift
//  Pokedex
//
//  Created by Wanaldino Antimonio on 2/9/22.
//

import CoreGraphics

extension CGRect {
	var center: CGPoint {
		CGPoint(
			x: midX,
			y: midY
		)
	}
}
