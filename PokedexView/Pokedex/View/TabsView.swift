//
//  TabView.swift
//  Pokedex
//
//  Created by Alvaro Orti Moreno on 6/9/22.
//

import SwiftUI
import PokedexModel

struct TabsView: View {
    @Binding var currentPokemon: Pokemon

	@State private var currentItem: String = "About"
	let items = [
		"About",
		"Base stats",
		"Evolution",
		"Moves"
	]

	@Namespace var animation

    var body: some View {
		GeometryReader { proxy in
			VStack {
				ScrollView(.horizontal, showsIndicators: false) {
					HStack {
						ForEach(items) { item in
							tabView(item: item)
                                .padding(.horizontal, 5)
						}
                    }
					.padding(.horizontal)
                    .frame(minWidth: proxy.size.width, alignment: .center)
                }
                .padding(.vertical, 16)

				TabView(selection: $currentItem) {
					PokemonBasicDetail(pokemon: currentPokemon)
						.tag(items[0])
					Color.red
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
                .fontWeight(.semibold)
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
        TabsView(currentPokemon: .constant(.mock))
    }
}
