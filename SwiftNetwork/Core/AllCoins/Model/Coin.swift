//
//  Coin.swift
//  SwiftNetwork
//
//  Created by Miaomiao Shi on 20/07/2024.
//

import Foundation

// We can only include what we want
struct Coin: Codable, Identifiable, Hashable {
    let id: String
    let symbol: String
    let name: String
    let currentPrice: Double
    let marketCapRank: Int
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name
        case currentPrice = "current_price"
        case marketCapRank = "market_cap_rank"
    }
}
