//
//  ArtistDetailsViewController.swift
//  TDLastFM
//
//  Created by Tiago Dias on 14/07/2017.
//  Copyright © 2017 Tiago Dias. All rights reserved.
//

import UIKit
import SafariServices

class ArtistDetailsViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var listenersLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var artistInfo: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    public var artist: ArtistProtocol?
    
    // Private properties
    fileprivate let serviceManager = ServiceManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        urlLabel.isUserInteractionEnabled = true
        urlLabel.addGestureRecognizer(tap)
        
        getInfo()
    }
    
    private func getInfo() {
        activityIndicator.startAnimating()
        
        if let name = artist?.name {
            let parameters = ["method": MethodType.info.rawValue, "artist": name]
            
            serviceManager.performAPIRequest(parameters: parameters) { [weak self] (result) in
                switch result {
                case let ArtistInfoResultType.success(artistInfo: json):
                    
                    if let artist = self?.artist {
                        artist.getInfoFrom(json: json)
                        self?.customiseWith(artist: artist)
                    }
                case let ArtistInfoResultType.failure(error: error):
                    self?.showError(error)
                default:
                    self?.showError(RequestError.jsonParsing(message: "Error performing Artist Info API Request"))
                }
                self?.activityIndicator.stopAnimating()
            }
        }
    }
    
    private func customiseWith(artist: ArtistProtocol) {
        
        if let imageUrlString = artist.image["large"],
            let url = URL(string: imageUrlString) {
            
            let data = try? Data(contentsOf: url)
            
            if let imageData = data {
                imageView?.image = UIImage(data: imageData)
            }
        }
        
        nameLabel.text = artist.name
        listenersLabel.text = "Listeners: " + artist.listeners
        urlLabel.text = artist.url
        if let summary = artist.summary {
            artistInfo.text = summary + "\n\n"
        }
        if let content = artist.content {
            artistInfo.text = content
        }
    }
    
    func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK",
                                         style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        navigationController?.present(alert, animated: true, completion: nil)
    }
    
    func handleTap() {
        
        if let urlString = artist?.url,
            let url = URL(string: urlString) {
            let svc = SFSafariViewController(url: url)
            present(svc, animated: true, completion: nil)
        }
    }
    
}
