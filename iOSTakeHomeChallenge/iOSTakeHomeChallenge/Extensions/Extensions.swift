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
