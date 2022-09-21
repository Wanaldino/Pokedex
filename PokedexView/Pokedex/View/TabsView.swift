//
//  TabView.swift
//  Pokedex
//
//  Created by Alvaro Orti Moreno on 6/9/22.
//

import SwiftUI
import PokedexModel

struct TabsView: View {
    @Binding var pokemon: Pokemon

	@State private var currentItem: String = "About"
	let items = [
		"About",
		"Stats",
		"Evolution",
		"Moves"
	]

	@Namespace var animation

    var body: some View {
		GeometryReader { proxy in
			VStack {
				ScrollView(.horizontal, showsIndicators: false) {
					HStack(spacing: 0) {
						ForEach(items) { item in
							tabView(item: item)
						}
						.font(.medium(size: 18))
                    }
					.padding(.horizontal)
                    .frame(minWidth: proxy.size.width, alignment: .center)
                }
                .padding(.vertical, 16)

				TabView(selection: $currentItem) {
					PokemonBasicDetail(pokemon: pokemon)
						.tag(items[0])
					PokemonStats(pokemon: $pokemon)
						.tag(items[1])
					Color.black
						.tag(items[2])
					Color.blue
						.tag(items[3])
				}
				.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
			}
		}
    }

    @ViewBuilder
    func tabView(item: String) -> some View {
        VStack(spacing: 8) {
            Text(item)
                .foregroundColor(currentItem == item ? .black : .gray)
                .lineLimit(1)

			RoundedRectangle(cornerRadius: 2, style: .continuous)
				.fill(currentItem == item ? .blue : .clear)
				.matchedGeometryEffect(id: "AnimationTab", in: animation, isSource: currentItem == item)
				.padding(.horizontal, 4)
				.frame(height: 2)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.easeInOut) { currentItem = item }
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView(pokemon: .constant(.mock))
    }
}
