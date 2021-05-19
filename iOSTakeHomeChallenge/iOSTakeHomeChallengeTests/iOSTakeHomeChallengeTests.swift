//
//  iOSTakeHomeChallengeTests.swift
//  iOSTakeHomeChallengeTests
//
//  Created by Matt Thomas on 19/05/2021.
//

import XCTest
@testable import iOSTakeHomeChallenge

class iOSTakeHomeChallengeTests: XCTestCase {
    
    var mockUrlSession: MockURLSession!
    var network: Network!
    
    struct SomeIntResponse: Decodable {
        let someInt: Int
    }
    
    override func setUp() {
        mockUrlSession = MockURLSession()
        network = Network()
    }
    
    func testDeserialise() throws {
        mockUrlSession.completeWithResponse = HTTPURLResponse(url: URL(fileURLWithPath: ""), statusCode: 200, httpVersion: nil, headerFields: nil)
        mockUrlSession.completeWithData = try JSONSerialization.data(withJSONObject: ["someInt": 120])
        
        network.makeRequest(url: URL(string: network.baseURL.appending(Endpoint.books))!, type: [Book].self, completionHandler: { error, books in
            if let books = books {
                assert((books as Any) is [Book])
            }
        })
    }
    
}
