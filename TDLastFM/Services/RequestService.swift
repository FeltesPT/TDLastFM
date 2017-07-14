//
//  RequestService.swift
//  TDLastFM
//
//  Created by Tiago Dias on 14/07/2017.
//  Copyright © 2017 Tiago Dias. All rights reserved.
//

import Foundation
import Alamofire

final class RequestService: NSObject {
    fileprivate let apiConfig: APIConfig
    
    init(config: APIConfig = APIConfig.lastFMConfig()) {
        self.apiConfig = config
        super.init()
    }
    
    fileprivate func requestGET(_ url: URL, completionHandler: @escaping (JSONRequestResult) -> Void) {
        Alamofire.request(url).responseJSON { (response) in
            
            if response.response?.statusCode != 200 {
                return completionHandler(.failure(error: RequestError.wrongStatusCode(message: "Something went wrong - Status code: \(String(describing: response.response?.statusCode))")))
            }
            
            if let error = response.error {
                return completionHandler(.failure(error: error))
            }
            
            guard let json = response.value as? [String:Any] else {
                return completionHandler(.failure(error: RequestError.jsonParsing(message: "Couldn't parse JSON Dictionary")))
            }
            
            completionHandler(.success(data: json))
        }
    }
}

extension RequestService: APIRequest {
    func performAPIRequest(parameters: [String:String], completionBlock: @escaping (JSONRequestResult) -> Void) {
        guard let url = URL.createAPIURL(withConfig: apiConfig, parameters: parameters) else {
            return completionBlock(.failure(error: RequestError.invalidUrl(message: "Can't create URL")))
        }
        
        requestGET(url, completionHandler: completionBlock)
    }
}
