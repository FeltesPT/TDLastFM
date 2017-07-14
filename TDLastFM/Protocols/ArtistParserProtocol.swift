//
//  ArtistParserProtocol.swift
//  TDLastFM
//
//  Created by Tiago Dias on 14/07/2017.
//  Copyright © 2017 Tiago Dias. All rights reserved.
//

import Foundation

enum ParseError: Error {
    case parseError(reason: String)
}

enum ArtistParseResultType {
    case success(artist: [Artist])
    case failure(error: Error)
}

protocol ArtistParserType {
    func parseArtists(data: [String: Any], completionBlock: (ArtistParseResultType) -> Void)
}
