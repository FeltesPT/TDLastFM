//
//  ArtistProtocol.swift
//  TDLastFM
//
//  Created by Tiago Dias on 13/07/2017.
//  Copyright © 2017 Tiago Dias. All rights reserved.
//

import Foundation

protocol ArtistType {
    var name: String { get }
    var mbid: String { get }
    var url: String { get }
    var image_small: String { get }
    var image: String { get }
    var streamable: Bool { get }
}

//<name>Cher</name>
//<mbid>bfcc6d75-a6a5-4bc6-8282-47aec8531818</mbid>
//<url>www.last.fm/music/Cher</url>
//<image_small>http://userserve-ak.last.fm/serve/50/342437.jpg</image_small>
//<image>http://userserve-ak.last.fm/serve/160/342437.jpg</image>
//<streamable>1</streamable>
