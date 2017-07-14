//
//  APIRequest.swift
//  TDLastFM
//
//  Created by Tiago Dias on 14/07/2017.
//  Copyright © 2017 Tiago Dias. All rights reserved.
//

import Foundation

enum JSONRequestResult {
    case success(data: [String:Any])
    case failure(error: Error)
}

enum RequestError: Error {
    case invalidUrl(message: String)
    case wrongStatusCode(message: String)
    case jsonParsing(message: String)
}

protocol APIRequest {
    func performAPIRequest(parameters: [String:String], completionBlock: @escaping (JSONRequestResult) -> Void)
}
