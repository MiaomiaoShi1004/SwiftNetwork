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
    
    init() {
        fetchPrice()
    }
    
    func fetchPrice() {
        let urlString = "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd"
        guard let url = URL(string: urlString) else { return } // converting a string to an actual url obj
        
        print("Fetching price...") // 1
        // Reach out to the URL and fetch data back
        URLSession.shared.dataTask(with: url) { data, response , error in
            // completion handler - also know as call back (make a call to the api - wait some time - get back from the server
            print("Did receieve data \(data)") // 3
        }.resume() // ! don't forget (mandatory to completion handler
        
        print("Did reach end of func...") // 2
    }
    
}


