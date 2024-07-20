//
//  CoinDataService.swift
//  SwiftNetwork
//
//  Created by Miaomiao Shi on 20/07/2024.
//

import Foundation

class CoinDataService {
    private let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=20&locale=en"
    // Using Result type
    func fetchCoinsWithResult(completion: @escaping(Result<[Coin], Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            guard let coins = try? JSONDecoder().decode([Coin].self, from: data) else {
                print("DEBUG: Failed to decode coins")
                return
            }

            completion(.success(coins))
        }.resume()
    }

    
    
    // completion handler getting back an array of coins
    func fetchCoins(completion: @escaping([Coin]?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else { return }
            
            guard let coins = try? JSONDecoder().decode([Coin].self, from: data) else {
                print("DEBUG: Failed to decode coins")
                return
            }

            completion(coins, nil)
        }.resume()
    }
    
    
    // create our own completion handler, it allow us to pass things from one component to another. (inside this parentheses define what you want to pass)
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
