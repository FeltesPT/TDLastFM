//
//  ArtistDetailsViewController.swift
//  TDLastFM
//
//  Created by Tiago Dias on 14/07/2017.
//  Copyright © 2017 Tiago Dias. All rights reserved.
//

import UIKit

class ArtistDetailsViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var listenersLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    
    public var artist: ArtistProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let artist = artist {
            customiseWith(artist: artist)
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
    }

}
