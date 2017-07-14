//
//  ArtistParser.swift
//  TDLastFM
//
//  Created by Tiago Dias on 14/07/2017.
//  Copyright © 2017 Tiago Dias. All rights reserved.
//

import Foundation

public typealias JSONObject = Any
public typealias JSONDictionary = [String: JSONObject]
public typealias JSONArray = [JSONObject]

final class ArtistParser: ArtistParserType {
    func parseArtists(data: [String: Any], completionBlock: (ArtistParseResultType) -> Void) {
        
        guard let results = data["results"] as? JSONDictionary else  {
            return completionBlock(.failure(error: ParseError.parseError(reason: "Results not found")))
        }
        
        guard let artistmatches = results["artistmatches"] as? JSONDictionary else {
            return completionBlock(.failure(error: ParseError.parseError(reason: "Artist Matches not found")))
        }
        
        guard let artistArray = artistmatches["artist"] as? [JSONDictionary] else {
            return completionBlock(.failure(error: ParseError.parseError(reason: "Artists List not found")))
        }
        
        var artistList = [Artist]()
        
        for singleArtistRaw in artistArray {

            guard let artist = Artist.parseArtist(artistRaw: singleArtistRaw) else {
                return completionBlock(.failure(error: ParseError.parseError(reason: "Artist Matches parsing failed")))
            }
            artistList.append(artist)
        }
        
        completionBlock(.success(artist: artistList))
    }
}
