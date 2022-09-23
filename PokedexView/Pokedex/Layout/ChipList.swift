//
//  ChipList.swift
//  Pokedex
//
//  Created by Wanaldino Antimonio on 23/9/22.
//

import SwiftUI

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
		//bounds.minX depends on padding modifier
		let padding = bounds.minX

		//We get the origin (with padding applyed) to start defining were views will be
		var origin = bounds.origin

		//Each Row has a list of views and the remaining space available
		//remainingSpace will ba used for alignments
		typealias Row = (views: [Subviews.Element], remainingSpace: Double)
		var currentRow: Row = ([], 0.0)
		var rows = [Row]()

		for view in subviews {
			let viewSize = view.sizeThatFits(proposal)

			//We ensure the next view fits in the remaining space.
			//origin.x is were the new view will be placed plus the width and a new space should be less than the bounds
			if origin.x + viewSize.width + horizontalSpacing > bounds.width {
				//If not we define the remaing row space as the total bounds width less the point we have filled with views plus a correction of a padding
				//And add it as a new completed row
				currentRow.remainingSpace = bounds.width - origin.x + padding
				rows.append(currentRow)

				//Resets currentRow views and origin
				currentRow.views.removeAll()
				origin.x = bounds.origin.x
			}

			//We add the view in the currentRow.
			//origin.x increases the width of the view plus the space
			currentRow.views.append(view)
			origin.x += viewSize.width
			origin.x += horizontalSpacing
		}

		//If currentRow has remaining data we add in a new row
		if !currentRow.views.isEmpty {
			currentRow.remainingSpace = bounds.width - origin.x + padding
			rows.append(currentRow)
		}

		//Reset origin to start placing views
		origin = bounds.origin
		for row in rows {
			//Depending on alignment originX starts on diferent point
			switch alignment {
			case .leading: //At the left
				origin.x = bounds.origin.x
			case .trailing: //At the remaingSpace (will fill the trailing space)
				origin.x = row.remainingSpace
			case .center: //At a half of remaingSpace (will fill until trailing space is also half of remaingSpace)
				origin.x = row.remainingSpace / 2
			}

			//Will be the max height of all items in row
			var maxHeight = 0.0

			for view in row.views {
				view.place(at: origin, proposal: proposal)

				let size = view.sizeThatFits(proposal)
				origin.x += size.width
				origin.x += horizontalSpacing

				maxHeight = max(maxHeight, size.height)
			}

			//Adds value for next row
			origin.y += maxHeight
			origin.y += verticalSpacing
		}
	}
}

struct ChipList_Previews: PreviewProvider {
    static var previews: some View {
		ChipList {
			ForEach((0 ... 100), id: \.self) { index in
				Text(index.description)
			}
		}
    }
}
