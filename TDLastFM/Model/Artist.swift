//
//  Artist.swift
//  TDLastFM
//
//  Created by Tiago Dias on 13/07/2017.
//  Copyright © 2017 Tiago Dias. All rights reserved.
//

import Foundation

final class Artist: NSObject, ArtistType {
    var name: String
    var mbid: String
    var url: String
    var image_small: String
    var image: String
    var streamable: Bool
    
    init(name: String, mbid: String, url: String, image_small: String, image: String, streamable: Bool) {
        self.name = name
        self.mbid = mbid
        self.url = url
        self.image_small = image_small
        self.image = image
        self.streamable = streamable
        
        super.init()
    }
}
