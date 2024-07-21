//
//  CoinDetails.swift
//  SwiftNetwork
//
//  Created by Miaomiao Shi on 21/07/2024.
//

import SwiftUI

struct CoinDetailsView: View {
    // dependency injection
    let coin: Coin
    @ObservedObject var viewModel: CoinDetailsViewModel
    
    init(coin: Coin) {
        self.coin = coin
        self.viewModel = CoinDetailsViewModel(coinId: coin.id)
    }
    
    var body: some View {
        Text(coin.name)
    }
}

//#Preview {
//    CoinDetailsView()
//}
