//
//  PokeballView.swift
//  Pokedex
//
//  Created by Wanaldino Antimonio on 2/9/22.
//

import SwiftUI

struct PokeballView: View {
	struct SquareShape: Shape {
		func path(in rect: CGRect) -> Path {
			Path(
				CGRect(
					origin: .zero,
					size: CGSize(width: rect.width, height: rect.height * 0.45)
				)
			)
		}
	}

    var shouldAnimate: Bool = true
	@State private var isAnimating = false


	var animation: Animation? {
        guard shouldAnimate else { return nil }
		return Animation.linear(duration: 2.0).repeatForever(autoreverses: false)
	}

	var body: some View {
		GeometryReader { proxy in
			ZStack {
				let size = proxy.size.width * 0.3
				Circle()
					.clipShape(AnnulusShape(size: size))
					.clipShape(SquareShape())

				Circle()
					.clipShape(AnnulusShape(size: size))
					.clipShape(SquareShape())
					.rotationEffect(.degrees(180))

				Circle()
					.frame(width: size * 0.8)
			}
			.foregroundColor(.white.opacity(0.4))
			.rotationEffect(Angle(degrees: isAnimating ? 360 : 0.0))
			.animation(animation, value: isAnimating)
			.onAppear { DispatchQueue.main.async { isAnimating = true } }
			.onDisappear { isAnimating = false }
		}
	}
}

struct PokeballView_Previews: PreviewProvider {
	static var previews: some View {
		PokeballView()
			.background(Color.red)
	}
}
