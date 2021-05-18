//
//  Network.swift
//  iOSTakeHomeChallenge
//
//  Created by Matt Thomas on 18/05/2021.
//

import Foundation

struct Endpoint {
    static let books = "books"
    static let houses = "houses"
    static let characters = "characters"
}

enum NetworkError: Error {
    case dataEmpty
    case dataInvalid
    case responseInvalid
    case statusCode(Int)
}

class Network {
    
    fileprivate let baseURL: String = "https://anapioficeandfire.com/api/"
    
    public func getBooks() -> [Book]? {
        var books: [Book]?  = nil
        let semaphore = DispatchSemaphore (value: 0)
        var request = URLRequest(url: URL(string: baseURL.appending(Endpoint.books))!)
        request.httpMethod = "GET"
        let config: URLSessionConfiguration = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 15
        config.httpAdditionalHeaders = ["Content-Type": "application/json"]
        let task = URLSession(configuration: config).dataTask(with: request, completionHandler: { (data, response, error) in
            if (error != nil) {
                self.handleError(error: error!)
            }
            guard let data = data else {
                print(NetworkError.dataEmpty)
                return
            }
            books = try? JSONDecoder().decode([Book].self, from: data)
            semaphore.signal()
        })
        task.resume()
        semaphore.wait()
        return books
    }
    
    func getHouses() -> [House]? {
        var houses: [House]? = nil
        let semaphore = DispatchSemaphore (value: 0)
        var request = URLRequest(url: URL(string: "https://anapioficeandfire.com/api/houses")!)
        request.httpMethod = "GET"
        let config: URLSessionConfiguration = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 15
        config.httpAdditionalHeaders = [
            "Content-Type": "application/json"
        ]
        let task = URLSession(configuration: config).dataTask(with: request, completionHandler: { (data, response, error) in
            if (error != nil) {
                self.handleError(error: error!)
            }
            guard let data = data else {
                print(NetworkError.dataEmpty)
                return
            }
            houses = try? JSONDecoder().decode([House].self, from: data)
            semaphore.signal()
        })
        task.resume()
        semaphore.wait()
        return houses
    }
    
    func getCharacters() -> [Character]? {
        var result: [Character]?  = nil
        let semaphore = DispatchSemaphore (value: 0)
        var request = URLRequest(url: URL(string: "https://anapioficeandfire.com/api/characters")!)
        request.httpMethod = "GET"
        let config: URLSessionConfiguration = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 15
        config.httpAdditionalHeaders = [
            "Content-Type": "application/json"
        ]
        let task = URLSession(configuration: config).dataTask(with: request, completionHandler: { (data, response, error) in
            if (error != nil) {
                self.handleError(error: error!)
            }
            guard let data = data else {
                print(NetworkError.dataEmpty)
                return
            }
            result = try? JSONDecoder().decode([Character].self, from: data)
            semaphore.signal()
        })
        task.resume()
        semaphore.wait()
        return result
    }
    
    private func handleError(error: Error) {
        print(error.localizedDescription)
        //TODO.. handle errors
    }
}
