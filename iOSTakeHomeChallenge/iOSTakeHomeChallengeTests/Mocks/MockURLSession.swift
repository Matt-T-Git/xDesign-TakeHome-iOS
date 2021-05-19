//
//  MockURLSession.swift
//  iOSTakeHomeChallengeTests
//
//  Created by Matt Thomas on 19/05/2021.
//

import Foundation

class MockURLSession: URLSession {
    var completeWithData: Data?
    var completeWithResponse: HTTPURLResponse?
    var completeWithError: Error?
    var getNextResponse: (URLRequest) -> HTTPURLResponse? = { _ in nil }

    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {

        let completeWithData = self.completeWithData
        let getNextResponse = self.getNextResponse
        let completeWithResponse = self.completeWithResponse
        let completeWithError = self.completeWithError

        return MockURLSessionDataTask {
            completionHandler(completeWithData, getNextResponse(request) ?? completeWithResponse, completeWithError)
        }
    }
}

class MockURLSessionDataTask: URLSessionDataTask {
    private let onResume: () -> Void

    //TODO: - Fix warning 
    init(onResume: @escaping () -> Void) {
        self.onResume = onResume
    }

    override func resume() {
        onResume()
    }

    override func cancel() {
    }
}
