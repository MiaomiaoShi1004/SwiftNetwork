//
//  CoinImageView.swift
//  SwiftNetwork
//
//  Created by Miaomiao Shi on 22/07/2024.
//

import SwiftUI

struct CoinImageView: View {
    @ObservedObject var imageLoader: ImageLoader

    init(url: String) {
        imageLoader = ImageLoader(url: url)
    }

    var body: some View {
        if let image = imageLoader.image {
            image
                .resizable()
        }
    }
}

#Preview {
    CoinImageView(url: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400")
}
