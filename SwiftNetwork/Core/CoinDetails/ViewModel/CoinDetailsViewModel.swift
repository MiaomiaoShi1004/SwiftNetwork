//
//  CoinDetailsViewModel.swift
//  SwiftNetwork
//
//  Created by Miaomiao Shi on 21/07/2024.
//

import Foundation

class CoinDetailsViewModel: ObservableObject {
    private let service: CoinServiceProtocol
    private let coinId: String
    
    @Published var coinDetails: CoinDetails? // fetchCoinDetails could fail
    
    init(coinId: String, service: CoinServiceProtocol) {
        self.service = service
        self.coinId = coinId
    }
    
    @MainActor // transition to the main thread
    func fetchCoinDetails() async {
        
        do {
            self.coinDetails = try await service.fetchCoinDetails(id: coinId)
        } catch {
            print("DEBUG: Error \(error.localizedDescription)")
        }
    }
}
