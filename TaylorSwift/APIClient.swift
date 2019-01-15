//
//  APIClient.swift
//  TaylorSwift
//
//  Created by Alfredo Barragan on 1/3/19.
//  Copyright © 2019 Alfredo Barragan. All rights reserved.
//

import Foundation
final class TaylorAPI {
    
    static func searchResults(keyword: String, completionHandler: @escaping (Error?, [Result]?) -> Void) {
        
        let urlString = "https://itunes.apple.com/search?media=music&limit=25&term=TaylorSwift"
        guard let url = URL(string: urlString) else {
            print("error")
            return
        }
        
        
        // use URLSession() to make network request to MeetupAPI
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let response = response as? HTTPURLResponse {
                print("response status code is \(response.statusCode)")
            }
            if let error = error {
                completionHandler(error, nil)
            } else if let data = data {
                // decoding of JSON using JSONDecoder()
                // can throw and error so needs to be wrapped in a
                // do{} catch{}
                do {
                    let TaylorData = try JSONDecoder().decode(TaylorSwift.self, from: data)
                    //closure captures value from network response
                    completionHandler(nil, TaylorData.results)
                } catch {
                    completionHandler(error, nil)
                }
            }
            
            }.resume()
    }
}
