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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // Private properties
    fileprivate let serviceManager = ServiceManager()
    fileprivate var artistList: [Artist]? = nil
    fileprivate var selectedIndexPath: IndexPath? = nil
    
    // Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Artist Search"
        
        let button = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(toggleSearch))
        navigationItem.rightBarButtonItem = button
    }
    
    // Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let targetViewController = segue.destination as? ArtistDetailsViewController {
            guard let indexPath = selectedIndexPath,
                let artist = artistList?[indexPath.row] else {
                    fatalError("Can't select artist on IndexPath: \(String(describing: selectedIndexPath))")
            }
            targetViewController.artist = artist
        }
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
        activityIndicator.startAnimating()
        
        guard let searchText = searchBar.text else {
            return
        }
        
        let parameters = ["method": MethodType.search.rawValue, "artist": searchText]
        
        serviceManager.performAPIRequest(parameters: parameters) { [weak self] (result) in
            switch result {
            case let ArtistListResultType.success(artistList: json):
                self?.artistList = json
                self?.tableView.reloadData()
            case let ArtistListResultType.failure(error: error):
                self?.showError(error)
            default:
                self?.showError(RequestError.jsonParsing(message: "Error performing Artist List API Request"))
            }
            self?.activityIndicator.stopAnimating()
        }
        
        searchBar.resignFirstResponder()
        toggleSearch()
    }
}

extension ArtistsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artistList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArtistCell") as? ArtistListTableViewCell else {
            fatalError("Can't")
        }
        
        guard let artist = artistList?[indexPath.row] else {
            return cell
        }
        
        cell.customiseWith(artist: artist)
        
        return cell
    }
    
}

extension ArtistsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        selectedIndexPath = indexPath
        
        performSegue(withIdentifier: "showDetails", sender: self)
    }
}
