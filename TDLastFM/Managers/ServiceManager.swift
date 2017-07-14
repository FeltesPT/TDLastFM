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
    fileprivate let parser: ArtistParserType
    
    init(request: APIRequest = RequestService(), parser: ArtistParser = ArtistParser()) {
        self.request = request
        self.parser = parser
    }
}

extension ServiceManager: ManagerResult {
    
    public func performAPIRequest(parameters: [String:String], completionBlock: @escaping (ManagerResultType) -> Void) {
        request.performAPIRequest(parameters: parameters) { (result) in
            switch result {
            case let .success(data: json):
                self.parser.parseArtists(data: json, completionBlock: { (result) in
                    switch result {
                    case let .success(artist: artistList):
                        completionBlock(.success(artistList: artistList))
                    case let .failure(error: error):
                        completionBlock(.failure(error: error))
                    }
                })
                break
            case let .failure(error: error):
                completionBlock(ManagerResultType.failure(error: error))
            }
        }
    }
}
