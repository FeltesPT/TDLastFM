//
//  ArtistsViewController.swift
//  TDLastFM
//
//  Created by Tiago Dias on 14/07/2017.
//  Copyright © 2017 Tiago Dias. All rights reserved.
//

import UIKit

class ArtistsViewController: UIViewController {
    
    // IBOutlets
    @IBOutlet var searchBarTopConstraint: NSLayoutConstraint! {
        didSet {
            searchBarTopConstraint.isActive = false
        }
    }
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    // Private properties
    fileprivate let serviceManager = ServiceManager()
    
    // Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Artist Search"
        
        let button = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(toggleSearch))
        navigationItem.rightBarButtonItem = button
    }
    
    // Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    // functions
    func toggleSearch() {
        searchBarTopConstraint.isActive = !searchBarTopConstraint.isActive
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK",
                                         style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        navigationController?.present(alert, animated: true, completion: nil)
    }
}

extension ArtistsViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        toggleSearch()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Searching...")
        
        guard let searchText = searchBar.text else {
            return 
        }
        
        let parameters = ["method":"artist.search", "artist": searchText]
        
        serviceManager.performAPIRequest(parameters: parameters) { (result) in
            switch result {
            case let .success(data: json):
                print(json)
            case let .failure(error: error):
                self.showError(error)
            }
        }
    }
}

extension ArtistsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}

extension ArtistsViewController: UITableViewDelegate {
    
}
