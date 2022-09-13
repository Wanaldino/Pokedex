//
//  TabView.swift
//  Pokedex
//
//  Created by Alvaro Orti Moreno on 6/9/22.
//

import SwiftUI
import PokedexModel

struct TabItemModel: Identifiable {
    var id: Int
    var name: String

    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

struct TabsView: View {
	@State private var currentItem: String = "About"

    @Binding var currentPokemon: Pokemon
    let animation: Namespace.ID

	let items = [
		"About",
		"Base stats",
		"Evolution",
		"Moves"
	]

    var body: some View {
		GeometryReader { proxy in
			VStack {
				ScrollView(.horizontal, showsIndicators: false) {
					HStack {
						ForEach(items) { item in
							tabView(item: item)
                                .padding(.horizontal, 5)
						}
                    }.padding(.horizontal)
                    .frame(minWidth: proxy.size.width, alignment: .center)
                }
                .padding(.vertical, 16)
				switch(items.firstIndex(of: currentItem)!) {
				case 0: PokemonBasicDetail(pokemon: currentPokemon)
				case 1: Color.red
				case 2: Color.black
				case 3: Color.blue
				default: EmptyView()
				}
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

            ZStack {
                if currentItem == item {
                    RoundedRectangle(cornerRadius: 2,style: .continuous)
                        .fill(.blue)
                        .matchedGeometryEffect(id: "AnimationTab", in: animation)
                } else {
                    RoundedRectangle(cornerRadius: 2,style: .continuous)
                        .fill(.clear)
                }
            }
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
        TabsView(currentPokemon: .constant(.mock), animation: Namespace().wrappedValue)
    }
}
