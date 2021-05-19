//
//  BooksViewModel.swift
//  iOSTakeHomeChallenge
//
//  Created by Matt Thomas on 19/05/2021.
//

import UIKit

class BooksViewModel: NSObject, UITableViewDataSource {
    
    private var cachedBooks: [Book] = []
    private let network = Network()
    
    func setupTableView(tableView: UITableView) {
        tableView.addBackground(imageName: "imgBooks")
        tableView.applyStyles()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BooksTableViewCell") as! BooksTableViewCell
        cell.setupWith(book: cachedBooks[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cachedBooks.count
    }
    
    func getData(completionHandler: @escaping (Bool) -> Void) {
        network.makeRequest(url: URL(string: network.baseURL.appending(Endpoint.books))!, type: [Book].self, completionHandler: { [self] error, books in
            if let books = books {
                cachedBooks = books
                completionHandler(true)
            }
        })
    }
}
