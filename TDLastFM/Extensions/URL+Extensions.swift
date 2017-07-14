//
//  URL+Extensions.swift
//  TDLastFM
//
//  Created by Tiago Dias on 13/07/2017.
//  Copyright © 2017 Tiago Dias. All rights reserved.
//

import Foundation

extension URL {
    static func createAPIURL(withConfig config: APIConfig, parameters: [String: String]? = nil) -> URL? {
        var components = URLComponents()
        components.scheme = config.apiScheme
        components.host = config.apiHost
        components.path = config.apiPath
        
        var allParameters: [String: String]
        if let parameters = parameters {
            allParameters = parameters
        } else {
            allParameters = [String: String]()
        }
        
        var queryItems = [URLQueryItem]()
        for (key, value) in allParameters {
            let queryItem = URLQueryItem(name: key, value: value)
            queryItems.append(queryItem)
        }
        
        queryItems.append(URLQueryItem(name: "format", value: "json"))
        queryItems.append(URLQueryItem(name: "api_key", value: config.apiIDKey))
        
        components.queryItems = queryItems
        
        return components.url
    }
}


//http://ws.audioscrobbler.com/2.0/?method=album.search&album=believe&api_key=YOUR_API_KEY&format=json
