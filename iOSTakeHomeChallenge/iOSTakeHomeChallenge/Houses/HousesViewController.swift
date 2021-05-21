//
//  HousesViewController.swift
//  iOSTakeHomeChallenge
//
//  Created by James Malcolm on 09/03/2021.
//

import UIKit

class HousesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private lazy var searchBar = UISearchBar(frame: CGRect.zero)
    private let viewModel = HousesViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadTable), name: Notification.Name("filteredHouses"), object: nil)
        
        tableView.addBackground(imageName: "imgHouses")
        tableView.dataSource = viewModel
        tableView.allowsSelection = false
        
        viewModel.setupSearchBar(searchBar: searchBar)
        navigationItem.titleView = searchBar
        viewModel.getData(isFiltered: false, searchText: "", completionHandler: {_ in  DispatchQueue.main.async {
                self.reloadTable()
            }
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
