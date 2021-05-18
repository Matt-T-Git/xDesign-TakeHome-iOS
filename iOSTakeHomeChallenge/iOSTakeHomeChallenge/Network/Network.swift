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
    case general
    case dataEmpty
    case responseInvalid
    case statusCode
    case jsonDecode
}

class Network {
    
    let baseURL: String = "https://anapioficeandfire.com/api/"
    
    func makeRequest<T: Decodable>(url: URL, type: T.Type, completionHandler: @escaping (_ error: Error?, _ myObject: T?) -> ()) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                self.handleError(error: error?.localizedDescription, type: .general)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if !(200...299).contains(httpResponse.statusCode) {
                    self.handleError(error: "Server Error", type: .statusCode, code: httpResponse.statusCode)
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
        case .general:
            print(error as Any)
        case .dataEmpty:
            print("Error! Empty Data")
        case .responseInvalid:
            print("Invalid response")
        case .statusCode:
            print(error?.appending(String(code ?? 0)) as Any)
        case .jsonDecode:
            print("JSON decoding error!")
        }
    }
}
