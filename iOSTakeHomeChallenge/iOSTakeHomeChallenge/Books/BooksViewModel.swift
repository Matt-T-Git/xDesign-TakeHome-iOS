//
//  BooksViewModel.swift
//  iOSTakeHomeChallenge
//
//  Created by Matt Thomas on 19/05/2021.
//

import UIKit

class BooksViewModel: NSObject, UITableViewDataSource, UISearchBarDelegate {
    
    private var cachedBooks: [Book] = []
    private var filteredBooks: [Book] = []
    private let network = Network()
    
    func setupTableView(tableView: UITableView) {
        tableView.addBackground(imageName: "imgBooks")
        tableView.applyStyles()
    }
    
    func setupSearchBar(searchBar: UISearchBar) {
        searchBar.delegate = self
        searchBar.addStyles()
        searchBar.placeholder = "Search"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BooksTableViewCell") as! BooksTableViewCell
        cell.setupWith(book: cachedBooks[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cachedBooks.count
    }
    
    func getData(isFiltered: Bool, searchText: String, completionHandler: @escaping (Bool) -> Void) {
        network.makeRequest(url: URL(string: network.baseURL.appending(Endpoint.books))!, type: [Book].self, completionHandler: { [self] error, books in
            if let books = books {
                let filtered = books.filter {book in return book.name.contains(searchText)}
                cachedBooks = isFiltered ? filtered : books
                completionHandler(true)
            }
        })
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchText = searchBar.text
        guard searchText!.isEmpty || searchText == "" else {
            getData(isFiltered: true, searchText: searchText!, completionHandler:  {_ in
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "filteredBooks"), object: nil)
            })
            return
        }
        
        getData(isFiltered: false, searchText: "", completionHandler:  {_ in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "filteredBooks"), object: nil)
        })
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
