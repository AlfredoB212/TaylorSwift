//
//  TaylorSwiftModel.swift
//  TaylorSwift
//
//  Created by Alfredo Barragan on 1/3/19.
//  Copyright © 2019 Alfredo Barragan. All rights reserved.
//

import Foundation
struct TaylorSwift: Codable {
    let results: [Result]
}

struct Result: Codable {
    let artistName: String
    let trackName: String
    let releaseDate: String
    let artworkUrl100: URL
    let trackID: Double?
    let trackViewUrl: String?
    let collectionName: String
    let collectionId: Int
}
