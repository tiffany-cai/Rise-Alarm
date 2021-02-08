//
//  Quote.swift
//  RiseAlarm
//
//  Created by Tiffany Cai on 5/16/20.
//  Copyright © 2020 Tiffany Cai. All rights reserved.
//

import Foundation

struct QuoteRequest {
    
    let urlString = "https://api.quotable.io/random/"
    
    func getQuote(completion:((_ quote: Quote)->())?) {
        
        let task = URLSession.shared.dataTask(with: URL(string: urlString)!, completionHandler: { data, response, error in
        
            guard let data = data, error == nil else {
                print("Something is wrong :(")
                return
            }
    
            do {
                let decoder = JSONDecoder()
                let quoteResult = try decoder.decode(Quote.self, from: data)
                
                completion?(quoteResult)
                
                //print("This is the quote: \(quoteResult)")
              
            }
            catch {
                print("failed to convert. \(error.localizedDescription)")
            }
        })
        task.resume()
    }
    
}
