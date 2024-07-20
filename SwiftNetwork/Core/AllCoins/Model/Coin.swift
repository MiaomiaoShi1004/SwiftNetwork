//
//  Coin.swift
//  SwiftNetwork
//
//  Created by Miaomiao Shi on 20/07/2024.
//

import Foundation

// We can only include what we want
struct Coin: Codable, Identifiable {
    let id: String
    let symbol: String
    let name: String
//    let currentPrice: Double
//    let marketCapRank: Int
}
