//
//  CoinDataService.swift
//  SwiftNetwork
//
//  Created by Miaomiao Shi on 20/07/2024.
//

import Foundation

class CoinDataService {
    // create our own completion handler, it allow us to pass things from one component to another
    func fetchPrice(coin: String, completion: @escaping(Double) -> Void) {
        let urlString = "https://api.coingecko.com/api/v3/simple/price?ids=\(coin)&vs_currencies=usd"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("DEBUG: failed with error \(error.localizedDescription)")
//                    self.errorMessage = error.localizedDescription
                return
            } // not using guard because if we use guard, there is an error, no print msg
            guard let httpResponse = response as? HTTPURLResponse else {
//                    self.errorMessage = "Bad HTTP Response"
                return
            }
            
            guard httpResponse.statusCode == 200 else {
//                    self.errorMessage = "Failed to fetch with status code \(httpResponse.statusCode)"
                return
            }
            
            guard let data = data else { return }
            guard let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
            guard let value = jsonObject[coin] as? [String: Double] else {
                print("failed to get price")
                return
            }
            guard let price = value["usd"] else { return } // safely unwrap optional
            
//                self.coin = coin.capitalized
//                self.price = "$\(price)"
            
            print("DEBUG: price in service is \(price)")
            completion(price)
        }.resume() // ! don't forget (mandatory to completion handler
    }
}
