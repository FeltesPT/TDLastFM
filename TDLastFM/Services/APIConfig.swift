//
//  APIConfig.swift
//  TDLastFM
//
//  Created by Tiago Dias on 13/07/2017.
//  Copyright © 2017 Tiago Dias. All rights reserved.
//

import Foundation

struct APIConfig {
    let apiScheme: String
    let apiHost: String
    let apiPath: String
    let apiIDKey: String
}

extension APIConfig {
    static func lastFMConfig() -> APIConfig {
        return APIConfig(apiScheme: "http",
                         apiHost: "ws.audioscrobbler.com",
                         apiPath: "/2.0/",
                         apiIDKey: "98aefad9f876d9f92787132e40edb587")
    }
}
