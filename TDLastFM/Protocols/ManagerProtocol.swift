//
//  ManagerProtocol.swift
//  TDLastFM
//
//  Created by Tiago Dias on 14/07/2017.
//  Copyright © 2017 Tiago Dias. All rights reserved.
//

import Foundation

enum ManagerResultType {
    case success(artistList: [Artist])
    case failure(error: Error)
}

protocol ManagerResult {
    func performAPIRequest(parameters: [String:String], completionBlock: @escaping (ManagerResultType) -> Void)
}
