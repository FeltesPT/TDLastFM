//
//  TDLastFMTests.swift
//  TDLastFMTests
//
//  Created by Tiago Dias on 13/07/2017.
//  Copyright © 2017 Tiago Dias. All rights reserved.
//

import XCTest
@testable import TDLastFM

class TDLastFMTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testNormalResponse() {
        
        let parser = ArtistParser()
        
        guard let response = getJsonFile(fileName: "NormalResponse") else {
            return XCTFail()
        }
        
        parser.parseArtists(data: response) { (result) in
            switch result {
            case let .success(artist: artistList):
                XCTAssertEqual(artistList.count, 30)
                
                let firstArtist = artistList.first
                XCTAssertEqual(firstArtist?.name, "Queen")
                XCTAssertEqual(firstArtist?.url, "https://www.last.fm/music/Queen")
                XCTAssertEqual(firstArtist?.image.count, 5)
                
            case .failure(error: _):
                XCTFail()
            }
        }
    }
    
    func testNoResultsKeyResponse() {
        
        let parser = ArtistParser()
        
        guard let response = getJsonFile(fileName: "NoResults") else {
            return XCTFail()
        }
        
        parser.parseArtists(data: response) { (result) in
            switch result {
            case .success(artist: _):
                XCTFail()
            case let .failure(error: error):
                XCTAssertNotNil(error)
                
            }
        }
    }
    
    func testNoArtistMatchesResponse() {
        
        let parser = ArtistParser()
        
        guard let response = getJsonFile(fileName: "NoArtistMatches") else {
            return XCTFail()
        }
        
        parser.parseArtists(data: response) { (result) in
            switch result {
            case .success(artist: _):
                XCTFail()
            case let .failure(error: error):
                XCTAssertNotNil(error)
            }
        }
    }

    func testNoArtistsListResponse() {
        
        let parser = ArtistParser()
        
        guard let response = getJsonFile(fileName: "NoArtists") else {
            return XCTFail()
        }
        
        parser.parseArtists(data: response) { (result) in
            switch result {
            case .success(artist: _):
                XCTFail()
            case let .failure(error: error):
                XCTAssertNotNil(error)
            }
        }
    }
    
}

extension TDLastFMTests {
    func getJsonFile(fileName: String) -> JSONDictionary? {
        
        let testBundle = Bundle(for: type(of: self))
        let url = testBundle.url(forResource: fileName, withExtension: "json")
        
        guard let data: Data = NSData(contentsOf: url!) as Data? else {return nil}
        
        do {
            let object = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            guard let dictionary = object as? JSONDictionary else {
                return nil
            }
            return dictionary
        } catch  {
            return nil
        }
    }
}
