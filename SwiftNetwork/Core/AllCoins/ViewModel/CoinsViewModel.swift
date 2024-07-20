//
//  CoinsViewModel.swift
//  SwiftNetwork
//
//  Created by Miaomiao Shi on 20/07/2024.
//

import Foundation

// Mark: fetch information from API and supply view with that data
class CoinsViewModel: ObservableObject {
    @Published var coin = ""
    @Published var price = ""
    @Published var errorMessage: String?
    
    init() {
        fetchPrice(coin: "bitcoin")

    }
    
    func fetchPrice(coin: String) {
        let urlString = "https://api.coingecko.com/api/v3/simple/price?ids=\(coin)&vs_currencies=usd"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
//                if let error = error {
//                    print("DEBUG: failed with error \(error.localizedDescription)")
//                    self.errorMessage = error.localizedDescription
//                    return
//                } // not using guard because if we use guard, there is an error, no print msg
                guard let httpResponse = response as? HTTPURLResponse else {
                    self.errorMessage = "Bad HTTP Response"
                    return
                }
                
                guard httpResponse.statusCode == 200 else {
                    self.errorMessage = "Failed to fetch with status code \(httpResponse.statusCode)"
                    return
                }
                
                print("DEBUG: Response code is \(httpResponse.statusCode)")
                
                guard let data = data else { return }
                guard let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
                guard let value = jsonObject[coin] as? [String: Double] else {
                    print("failed to get price")
                    return
                }
                guard let price = value["usd"] else { return } // safely unwrap optional
                
                self.coin = coin.capitalized
                self.price = "$\(price)"
            }
        }.resume() // ! don't forget (mandatory to completion handler
    }
    
}


