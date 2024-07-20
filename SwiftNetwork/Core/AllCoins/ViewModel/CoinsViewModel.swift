//
//  CoinsViewModel.swift
//  SwiftNetwork
//
//  Created by Miaomiao Shi on 20/07/2024.
//

import Foundation

// Mark: fetch information from API and supply view with that data
class CoinsViewModel: ObservableObject {
    @Published var coins = [Coin]()
    
    private let service = CoinDataService()
    
    init() {
        fetchCoins()
    }
    
    func fetchCoins() {
        service.fetchCoins { coins in
            DispatchQueue.main.async {
                self.coins = coins
            }
        }
    }

}


