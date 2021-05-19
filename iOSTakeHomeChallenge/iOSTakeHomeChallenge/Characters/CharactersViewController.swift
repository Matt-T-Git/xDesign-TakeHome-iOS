//
//  CharactersViewController.swift
//  iOSTakeHomeChallenge
//
//  Created by James Malcolm on 09/03/2021.
//

import UIKit

class CharactersViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private let viewModel = CharactersViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.dataSource = viewModel
        tableView.addBackground(imageName: "imgCharacters")
        viewModel.getData() {_ in 
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
