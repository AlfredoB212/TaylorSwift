//
//  NetworkHelper.swift
//  TaylorSwift
//
//  Created by Alfredo Barragan on 1/3/19.
//  Copyright © 2019 Alfredo Barragan. All rights reserved.
//

import Foundation
//final class NetworkHelper {
//    static func performDataTask(urlString: String, httpMethod: String, completionHandler: @escaping (Error?, Data?) ->Void) {
//        guard let url = URL(string: urlString) else {
//            print("not working")
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = httpMethod
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//
//            if let error = error {
//                completionHandler(error, nil)
//            }
//            if let response = response as? HTTPURLResponse {
//                print("also not working")
//            }
//            if let data = data {
//                completionHandler(nil, data)
//            }
//            }.resume()
//    }
//}
public final class NetworkHelper {
    private init() {
        let cache = URLCache(memoryCapacity: 10 * 1024 * 1024, diskCapacity: 10 * 1024 * 1024, diskPath: nil)
        URLCache.shared = cache
    }
    public static let shared = NetworkHelper()
    
    public func performDataTask(endpointURLString: String,
                                completionHandler: @escaping (AppError?, Data?, HTTPURLResponse?) ->Void) {
        guard let url = URL(string: endpointURLString) else {
            completionHandler(AppError.badURL("\(endpointURLString)"), nil, nil)
            return
        }
        var request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completionHandler(AppError.networkError(error), nil, response as? HTTPURLResponse)
                return
            } else if let data = data {
                completionHandler(nil, data, response as? HTTPURLResponse)
            }
        }
        task.resume()
    }
}
