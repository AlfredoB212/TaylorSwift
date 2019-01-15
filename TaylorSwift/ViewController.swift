//
//  ViewController.swift
//  TaylorSwift
//
//  Created by Alfredo Barragan on 1/3/19.
//  Copyright © 2019 Alfredo Barragan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var musicTableView: UITableView!
    


private var results = [Result](){
    didSet {
        DispatchQueue.main.async {
            self.title = "TaylorSwift (\(self.results.count)"
            self.musicTableView.reloadData()
        }
    }
}

override func viewDidLoad() {
    super.viewDidLoad()
    musicTableView.dataSource = self
    searchResults(keyWord: "TaylorSwift")
}
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let indexPath = musicTableView.indexPathForSelectedRow, let destination = segue.destination as? DetailViewController else { fatalError("index path nil") }
    let result = results[indexPath.row]
    destination.result = result
}
    


func searchResults(keyWord: String) {
    TaylorAPI.searchResults(keyword: "TaylorSwift") { (error, results) in
        if let error = error {
            print("error: \(error)")
        } else if let results = results {
            self.results = results
        }
    }
}
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = musicTableView.dequeueReusableCell(withIdentifier: "SwiftCell", for: indexPath)
        let resultsToSet = results[indexPath.row]
        cell.textLabel?.text = resultsToSet.trackName
        cell.detailTextLabel?.text = resultsToSet.artistName
        
        if let image = ImageHelper.shared.image(forKey: resultsToSet.artworkUrl100.absoluteString as NSString) {
            cell.imageView?.image = image
        } else {
            ImageHelper.shared.fetchImage(urlString: resultsToSet.artworkUrl100.absoluteString) { (appError, image) in
                if let appError = appError {
                    print(appError.errorMessage())
                } else if let image = image {
                    cell.imageView?.image = image
                }
            }
        }
        
        return cell
    }
        
        
    }
    
    


