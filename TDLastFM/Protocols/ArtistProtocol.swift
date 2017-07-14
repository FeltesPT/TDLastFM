//
//  ArtistProtocol.swift
//  TDLastFM
//
//  Created by Tiago Dias on 13/07/2017.
//  Copyright © 2017 Tiago Dias. All rights reserved.
//

import Foundation

protocol ArtistProtocol {
    var name: String { get }
    var listeners: String { get }
    var url: String { get }
    var image: [String:String] { get }
}
