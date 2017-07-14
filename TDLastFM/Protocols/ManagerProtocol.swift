//
//  ManagerProtocol.swift
//  TDLastFM
//
//  Created by Tiago Dias on 14/07/2017.
//  Copyright © 2017 Tiago Dias. All rights reserved.
//

import Foundation

protocol ResultType { }

enum ArtistListResultType: ResultType {
    case success(artistList: [Artist])
    case failure(error: Error)
}

enum ArtistInfoResultType: ResultType {
    case success(artistInfo: JSONDictionary)
    case failure(error: Error)
}

protocol ManagerResult {
    func performAPIRequest(parameters: [String:String], completionBlock: @escaping (ResultType) -> Void)
}
