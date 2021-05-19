//
//  BooksViewController.swift
//  iOSTakeHomeChallenge
//
//  Created by James Malcolm on 09/03/2021.
//

import UIKit

class BooksViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private let viewModel = BooksViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.setupTableView(tableView: tableView)
        tableView.dataSource = viewModel
        viewModel.getData() {_ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
