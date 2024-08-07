//
//  CoinDetails.swift
//  SwiftNetwork
//
//  Created by Miaomiao Shi on 21/07/2024.
//

import Foundation

struct CoinDetails: Codable {
    let id: String
    let symbol: String
    let name: String
    let description: Description
    
}

struct Description: Codable {
    let text: String // This is just for better naming, if no CodingKeys -> let en: String
    
    enum CodingKeys: String, CodingKey {
        case text = "en"
    }
}
