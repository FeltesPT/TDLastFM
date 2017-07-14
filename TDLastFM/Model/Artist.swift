//
//  Artist.swift
//  TDLastFM
//
//  Created by Tiago Dias on 13/07/2017.
//  Copyright © 2017 Tiago Dias. All rights reserved.
//

import Foundation

final class Artist: NSObject, ArtistProtocol {
    var name: String
    var listeners: String
    var url: String
    var image: [String:String]
    var summary: String?
    var content: String?
    
    init(name: String, listeners: String, url: String, image: [String:String]) {
        self.name = name
        self.listeners = listeners
        self.url = url
        self.image = image
        
        super.init()
    }
    
    static func parseArtist(artistRaw: JSONDictionary) -> Artist? {
        
        if let name = artistRaw["name"] as? String,
            let listeners = artistRaw["listeners"] as? String,
            let url = artistRaw["url"] as? String,
            let images = artistRaw["image"] as? [[String:String]] {
            
            var imageDict = [String:String]()
            
            for image in images {
                
                if let key = image["size"] {
                    imageDict[key] = image["#text"]
                }
            }
            
            return Artist.init(name: name, listeners: listeners, url: url, image: imageDict)
        }
        
        return nil
    }
    
    public func getInfoFrom(json: JSONDictionary) {
        
        if let artist = json["artist"] as? JSONDictionary,
            let bio = artist["bio"] as? JSONDictionary {
            summary = bio["summary"] as? String
            content = bio["content"] as? String
        }
        
        
    }
}
