//
//  BooksViewController.swift
//  iOSTakeHomeChallenge
//
//  Created by James Malcolm on 09/03/2021.
//

import Foundation
import UIKit

class BooksViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var cachedBooks: [Book] = []
    private let network = Network()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTableView()
        getBooks()
    }
    
    private func setupTableView() {
        tableView.addBackground(imageName: "imgBooks")
        tableView.applyStyles()
    }
    
    private func getBooks() {
        if let data = network.getBooks() { loadData(books: data) }
    }
    
    private func loadData(books: [Book]) {
        cachedBooks = books
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cachedBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BooksTableViewCell") as! BooksTableViewCell
        cell.setupWith(book: cachedBooks[indexPath.row])
        return cell
    }
}
