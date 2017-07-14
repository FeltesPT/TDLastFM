//
//  ServiceManager.swift
//  TDLastFM
//
//  Created by Tiago Dias on 14/07/2017.
//  Copyright © 2017 Tiago Dias. All rights reserved.
//

import Foundation

final class ServiceManager: NSObject {
    fileprivate let request: APIRequest
    
    init(request: APIRequest = RequestService()) {
        self.request = request
    }
    
    public func performAPIRequest(parameters: [String:String], completionBlock: @escaping (JSONRequestResult) -> Void) {
        request.performAPIRequest(parameters: parameters) { (result) in
            switch result {
            case let .success(data: json):
                // Add parser
                break
            case let .failure(error: error):
                completionBlock(JSONRequestResult.failure(error: error))
            }
        }
    }
}
