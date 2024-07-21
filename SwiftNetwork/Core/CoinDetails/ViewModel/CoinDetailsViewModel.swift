//
//  CoinDetailsViewModel.swift
//  SwiftNetwork
//
//  Created by Miaomiao Shi on 21/07/2024.
//

import Foundation

class CoinDetailsViewModel: ObservableObject {
    private let service = CoinDataService()
    private let coinId: String
    
    @Published var coinDetails: CoinDetails? // fetchCoinDetails could fail
    
    init(coinId: String) {
        print("DEBUG: did init...") // this has been solved
        self.coinId = coinId
        
//        Task { await fetchCoinDetails() }
    }
    
    @MainActor // transition to the main thread
    func fetchCoinDetails() async {
        print("DEBUG: Fetching coins")
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        print("DEBUG: Task woke up")
        
        do {
            let details = try await service.fetchCoinDetails(id: coinId)
            print("DEBUG: Details \(details)")
            self.coinDetails = details
        } catch {
            print("DEBUG: Error \(error.localizedDescription)")
        }
    }
}
