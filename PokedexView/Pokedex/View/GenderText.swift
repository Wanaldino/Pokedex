//
//  GenderText.swift
//  Pokedex
//
//  Created by Wanaldino Antimonio on 19/9/22.
//

import SwiftUI
import PokedexModel

struct GenderText: View {
	@State var gender: Pokemon.AditionalInfo.Gender

	var color: Color {
		let color: Color.Color
		switch gender {
		case .female: color = .female
		case .male: color = .male
		case .genderless: color = .genderless
		}
		return Color(color)
	}

    var body: some View {
		HStack {
			if let image = gender.image {
				Image(image)
					.resizable()
					.renderingMode(.template)
					.aspectRatio(contentMode: .fit)
					.foregroundColor(color)
					.frame(width: 20, height: 20)
			}

			let percentage = gender.rate * 100
			Text(String(format: "%.1f%", percentage))
				.foregroundColor(color)
		}
    }
}

struct GenderText_Previews: PreviewProvider {
    static var previews: some View {
		GenderText(gender: .male(0.33))
    }
}
