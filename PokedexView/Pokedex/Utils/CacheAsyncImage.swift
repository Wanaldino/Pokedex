//
//  CacheAsyncImage.swift
//  Pokedex
//
//  Created by Alvaro Orti Moreno on 8/9/22.
//

import SwiftUI

struct CacheAsyncImage<Content>: View where Content: View {
    private let url: URL
    private let content: (AsyncImagePhase) -> Content

    init(
        url: URL,
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ) {
        self.url = url
        self.content = content
    }

    var body: some View {
        if let image = ImageCache[url] {
            content(.success(image))

        } else {
            AsyncImage(url: url) { phase in
                cacheAndRender(url: url, phase: phase)
            }
        }
    }

    private func cacheAndRender(url: URL, phase: AsyncImagePhase) -> some View {
        if case .success(let image) = phase {
           ImageCache[url] = image
        }
        return content(phase)
    }
}

private class ImageCache {
    static private var cache: [URL: Image] = [:]

    static subscript(url: URL) -> Image? {
        get {
            cache[url]
        }
        set {
            cache[url] = newValue
        }
    }
}
