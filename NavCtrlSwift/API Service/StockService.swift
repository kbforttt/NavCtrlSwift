//
//  StockService.swift
//  NavCtrlSwift
//
//  Created by Aditya Narayan on 6/27/19.
//  Copyright © 2019 TurnToTech. All rights reserved.
//

import Foundation



class StockService {
    
    static let API_KEY = "RvF_6czQmQe-e9TVqwQfg-ooXTs9ItBM"
    
    class func getStockPrices(tickers: [String], closure:@escaping (String, Double) -> Void) {
        
        
        for ticker in tickers{
            
              
            let urlString = "https://api.unibit.ai/api/realtimestock/\(ticker)?size=1&AccessKey=\(API_KEY)"
            let url = URL(string: urlString)!
            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                guard let data = data else { return }
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]
                    
                    if  let stockArray = json?["Realtime Stock price"] as? [Any],
                        let stockData = stockArray[0] as? [String:Any] {
                        
                        if let ticker = stockData["ticker"] as? String,
                            let price = stockData["price"] as? Double {
                            
                            closure(ticker, price)
                        }
                        
                        
                        
                    }
                    
                    if json?["Realtime Stock price"] == nil {
                        print("Something went wrong")
                    }
                    
                    
                } catch {
                    print("Something went wrong")
                }
               
            }
            
            task.resume()
        }
       
        
        
        
        
        
        
        
        
  
    }
    
    func getQuote(index: Int, ticker: String){
        
    }
    
}
