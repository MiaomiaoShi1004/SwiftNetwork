//
//  SwiftNetworkTests.swift
//  SwiftNetworkTests
//
//  Created by Miaomiao Shi on 21/07/2024.
//

import XCTest
@testable import SwiftNetwork

final class NetworkingTutorialTests: XCTestCase {

    func test_DecodeCoinsIntoArray_marketCapDesc() throws {
        do {
            let coins = try JSONDecoder().decode([Coin].self, from: mockCoinData_marketCapDesc)
            XCTAssertTrue(coins.count > 0) // ensures that coins array has coins
            XCTAssertEqual(coins.count, 20) // ensures that all coins were decoded
            XCTAssertEqual(coins, coins.sorted(by: { $0.marketCapRank < $1.marketCapRank })) // ensures sorting order
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
