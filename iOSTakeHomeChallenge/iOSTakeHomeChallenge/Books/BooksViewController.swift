//
//  BooksViewController.swift
//  iOSTakeHomeChallenge
//
//  Created by James Malcolm on 09/03/2021.
//

import UIKit

class BooksViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private lazy var searchBar = UISearchBar(frame: CGRect.zero)
    private let viewModel = BooksViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadTable), name: Notification.Name("filteredBooks"), object: nil)
        
        tableView.dataSource = viewModel
        viewModel.setupTableView(tableView: tableView)
        viewModel.setupSearchBar(searchBar: searchBar)
        
        navigationItem.titleView = searchBar
        viewModel.getData(isFiltered: false, searchText: "", completionHandler:  {_ in self.reloadTable()
        })
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        tap.cancelsTouchesInView = false
        tableView.addGestureRecognizer(tap)
    }
    
    @objc private func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc private func hideKeyboard() {
        searchBar.endEditing(true)
    }
}
