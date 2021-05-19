//
//  Extensions.swift
//  iOSTakeHomeChallenge
//
//  Created by Matt Thomas on 18/05/2021.
//

import UIKit

extension UITableView {
    func applyStyles() {
        self.contentInset = UIEdgeInsets(top: 220, left: 0, bottom: 0, right: 0)
        backgroundView = UIImageView(image: UIImage(named: "imgBooks"))
    }
    
    func addBackground(imageName: String) {
       backgroundView =  UIImageView(image: UIImage(named: imageName))
    }
}

extension String {
    func toYearMonth() -> String {
        var monthYear = ""
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "MMM yyyy"
            monthYear = dateFormatter.string(from: date)
            return monthYear
        }
        return monthYear
    }
}

extension UISearchBar {
    func addStyles() {
        placeholder = "Search"
        searchTextField.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        searchTextField.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        searchTextField.leftView?.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        searchTextField.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
}
