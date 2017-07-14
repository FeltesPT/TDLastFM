//
//  ArtistListTableViewCell.swift
//  TDLastFM
//
//  Created by Tiago Dias on 14/07/2017.
//  Copyright © 2017 Tiago Dias. All rights reserved.
//

import UIKit

class ArtistListTableViewCell: UITableViewCell {

    public func customiseWith(artist: Artist) {
        textLabel?.text = artist.name
        detailTextLabel?.text = "Listeners: \(artist.listeners)"
        
        DispatchQueue.global().async {
            
            if let imageUrlString = artist.image["small"],
                let url = URL(string: imageUrlString) {
                
                let data = try? Data(contentsOf: url)
                
                if let imageData = data {
                    DispatchQueue.main.async {
                        self.imageView?.image = UIImage(data: imageData)
                        self.setNeedsLayout()
                    }
                }
                
            }
        }

    }

}
