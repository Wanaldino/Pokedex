//
//  View + backButton.swift
//  Pokedex
//
//  Created by Wanaldino Antimonio on 2/9/22.
//

import SwiftUI

extension View {
	func backButton(path : Binding<NavigationPath>) -> some View {
		modifier(ToolbarBackButton(path: path))
	}
}

struct ToolbarBackButton: ViewModifier {
	@Binding var path : NavigationPath

	func body(content: Content) -> some View {
		content
			.toolbar {
				ToolbarItem(placement: .navigationBarLeading) {
					Image(systemName: "chevron.left")
						.foregroundColor(.white)
						.onTapGesture {
							path.removeLast()
						}
				}
			}
	}
}
