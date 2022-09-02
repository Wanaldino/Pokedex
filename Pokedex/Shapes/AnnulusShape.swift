//
//  AnnulusShape.swift
//  Pokedex
//
//  Created by Wanaldino Antimonio on 2/9/22.
//

import SwiftUI

struct AnnulusShape: Shape {
	let size: Double

	func path(in rect: CGRect) -> Path {
		var path = Path()
		path.move(to: CGPoint(x: 0, y: rect.midY))
		path.addArc(
			center: rect.center,
			radius: rect.width / 2,
			startAngle: .zero,
			endAngle: .degrees(180),
			clockwise: true
		)
		path.addLine(to: CGPoint(x: rect.maxX - size, y: rect.midY))
		path.addArc(
			center: rect.center,
			radius: rect.width / 2 - size,
			startAngle: .degrees(180),
			endAngle: .zero,
			clockwise: false
		)
		path.addLine(to: CGPoint(x: 0, y: rect.midY))

		path.closeSubpath()
		return path
	}
}

struct AnnulusShape_Previews: PreviewProvider {
    static var previews: some View {
		AnnulusShape(size: 10)
		AnnulusShape(size: 20)
		AnnulusShape(size: 30)
		AnnulusShape(size: 40)
		AnnulusShape(size: 50)
    }
}
