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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getBooks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupTableView()
        super.viewWillAppear(animated)
    }
    
    private func setupTableView() {
        tableView.addBackground(imageName: "imgBooks")
        tableView.applyStyles()
    }
    
    func getBooks() {
        if let data = network.getBooks() {
            loadData(books: data)
        }
    }
    
    func loadData(books: [Book]) {
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

class BooksTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var pagesLabel: UILabel!
    
    func setupWith(book: Book) {
        titleLabel.text = book.name
        
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let date = dateFormatter.date(from: book.released) {
            dateFormatter.dateFormat = "MMM yyyy"
            let monthYear = dateFormatter.string(from: date)
            dateLabel.text = monthYear
        }
        pagesLabel.text = "\(book.numberOfPages) pages"
    }
}
