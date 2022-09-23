//
//  PokemonStats.swift
//  Pokedex
//
//  Created by Wanaldino Antimonio on 21/9/22.
//

import SwiftUI
import PokedexModel

struct PokemonStats: View {
	@Binding var pokemon: Pokemon
	@State var effectivities: [TypeManager.MixedEffectivity]?

    var body: some View {
		GeometryReader { proxy in
			VStack(alignment: .leading) {
				let textWidth = proxy.size.width * 0.3
				let valueWidth = 30.0
				let columns = [GridItem(.flexible(minimum: 0, maximum: textWidth)), GridItem(.fixed(valueWidth)), GridItem()]
				LazyVGrid(columns: columns, alignment: .leading, spacing: 8) {
					ForEach(pokemon.stats) { stat in
						Text(stat.name.replacingOccurrences(of: "Special", with: "Sp."))
							.font(.medium(size: 18))
							.foregroundColor(Color.gray)
						Text(stat.value.description)
							.font(.book(size: 16))

						let value = Double(stat.value)
						let maxValue = Double(Pokemon.Stat.maxValue)
						ProgressView(value: value, total: maxValue)
							.tint(value / maxValue < 0.4 ? .red : .green)
							.animation(.linear, value: pokemon)
					}
				}.padding(.bottom, 32)

				if let effectivities {
					Text("Type defenses")
						.font(.bold(size: 24))

					ChipList {
						ForEach(effectivities) { effectivity in
							Effectivity(effectivity: effectivity)
						}
					}
				} else {
					Text("Waiting for data...")
						.foregroundColor(.black)
						.font(.book(size: 16))
				}
			}
			.onChange(of: pokemon, perform: { newValue in
				retrieveEffecties()
			})
			.task {
				retrieveEffecties()
			}
			.padding(.horizontal)
		}
    }

	func retrieveEffecties() {
		Task {
			effectivities = await TypeManager.shared.effectivity(defender: pokemon.types)
		}
	}
}

struct PokemonStats_Previews: PreviewProvider {
    static var previews: some View {
		PokemonStats(pokemon: .constant(Pokemon.mock))
    }
}



struct ChipList: Layout {
	enum Alignment {
		case leading, trailing, center
	}
	let horizontalSpacing: Double
	let verticalSpacing: Double
	let alignment: Alignment

	init(horizontalSpacing: Double = 8, verticalSpacing: Double = 8, alignment: Alignment = .leading) {
		self.horizontalSpacing = horizontalSpacing
		self.verticalSpacing = verticalSpacing
		self.alignment = alignment
	}

	func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
		CGSize(width: proposal.width ?? 0, height: proposal.height ?? 0)
	}

	func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
		let padding = bounds.minX
		var origin = bounds.origin

		typealias Row = (views: [Subviews.Element], remainingSpace: Double)
		var currentRow: Row = ([], 0.0)
		var rows = [Row]()

		for view in subviews {
			let viewSize = view.sizeThatFits(proposal)

			if origin.x + viewSize.width + horizontalSpacing > bounds.width {
				currentRow.remainingSpace = bounds.maxX - origin.x + padding
				rows.append(currentRow)
				currentRow.views.removeAll()
				origin.x = bounds.origin.x
			}

			currentRow.views.append(view)
			origin.x += viewSize.width
			origin.x += horizontalSpacing
		}

		if !currentRow.views.isEmpty {
			currentRow.remainingSpace = bounds.maxX - origin.x + padding
			rows.append(currentRow)
		}

		origin = bounds.origin
		for row in rows {
			switch alignment {
			case .leading:
				origin.x = bounds.origin.x
			case .trailing:
				origin.x = row.remainingSpace
			case .center:
				origin.x = row.remainingSpace / 2
			}

			var maxHeight = 0.0

			for view in row.views {
				view.place(at: origin, proposal: proposal)

				let size = view.sizeThatFits(proposal)
				origin.x += size.width
				origin.x += horizontalSpacing

				maxHeight = max(maxHeight, size.height)
			}

			origin.y += maxHeight
			origin.y += verticalSpacing
		}
	}
}
