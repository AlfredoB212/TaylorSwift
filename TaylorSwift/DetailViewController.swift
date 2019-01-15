//
//  DetailViewController.swift
//  TaylorSwift
//
//  Created by Alfredo Barragan on 1/3/19.
//  Copyright © 2019 Alfredo Barragan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var albumArtwork: UIImageView!
    
    public var result: Result!
        
    override func viewDidLoad() {
        super.viewDidLoad()
            updateEventUI()
            
        }
    
    @IBAction func linkToMusic(_ sender: UIButton) {
         let musicLink = "https://itunes.apple.com/us/album/\(result.collectionName.lowercased())/\(result.collectionId)"
        guard let url = URL(string: musicLink) else {return}
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    
    }
    
        private func updateEventUI() {
            title = result.trackName
            
            trackName.text = result.trackName
            artistName.text = result.artistName
            releaseDate.text = ("Release Date  \(result.releaseDate)")
            
            if let image = ImageHelper.shared.image(forKey: result.artworkUrl100.absoluteString as NSString) {
                albumArtwork.image = image
            }
}
}

