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
    case connection
    case dataEmpty
    case general
    case jsonDecode
    case serverError
}

class Network {
    
    let baseURL: String = "https://anapioficeandfire.com/api/"
    
    func makeRequest<T: Decodable>(url: URL, type: T.Type, completionHandler: @escaping (_ error: Error?, _ myObject: T?) -> ()) {
        
        guard ConnectionChecker.isConnectedToNetwork() else {
            self.handleError(error: nil, type: .connection)
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                self.handleError(error: error?.localizedDescription, type: .general)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if !(200...299).contains(httpResponse.statusCode) {
                    self.handleError(error: "Server Error", type: .serverError, code: httpResponse.statusCode)
                }
            }
            
            guard let data = data else {
                self.handleError(type: .dataEmpty)
                return
            }
            
            do {
                let myNewObject = try JSONDecoder().decode(T.self, from: data)
                completionHandler(nil, myNewObject)
            } catch let error {
                completionHandler(error, nil)
                return
            }
        }.resume()
    }
    
    private func handleError(error: String? = nil, type: NetworkError, code: Int? = nil) {
    
        switch type {
        case .connection:
            print("Connection Error!, Unable to connect to the internet.")
        case .general:
            print("Error: \(error ?? "Unknown")")
        case .dataEmpty:
            print("Error! Empty Data")
        case .serverError:
            if let error = error {print(error.appending(String(code ?? 0)))}
        case .jsonDecode:
            print("JSON Decoding Error!, Unable to Decode JSON.")
        }
    }
}
