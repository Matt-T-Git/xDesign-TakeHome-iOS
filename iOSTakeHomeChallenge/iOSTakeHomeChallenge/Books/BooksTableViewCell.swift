//
//  BooksTableViewCell.swift
//  iOSTakeHomeChallenge
//
//  Created by Matt Thomas on 18/05/2021.
//

import UIKit

class BooksTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var pagesLabel: UILabel!
    
    func setupWith(book: Book) {
        titleLabel.text = book.name
        dateLabel.text = book.released.toYearMonth()
        pagesLabel.text = String(book.numberOfPages).appending(" pages")
    }
}
