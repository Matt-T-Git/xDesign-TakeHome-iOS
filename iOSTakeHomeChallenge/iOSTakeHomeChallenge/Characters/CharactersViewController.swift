//
//  CharactersViewController.swift
//  iOSTakeHomeChallenge
//
//  Created by James Malcolm on 09/03/2021.
//

import UIKit

class CharactersViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private lazy var searchBar = UISearchBar(frame: CGRect.zero)
    private let viewModel = CharactersViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadTable), name: Notification.Name("filteredCharacters"), object: nil)
        tableView.dataSource = viewModel
        viewModel.setupSearchBar(searchBar: searchBar)
        navigationItem.titleView = searchBar
        tableView.addBackground(imageName: "imgCharacters")
        viewModel.getData() {_ in self.reloadTable()}
    }
    
    @objc private func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
