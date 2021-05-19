//
//  HousesViewController.swift
//  iOSTakeHomeChallenge
//
//  Created by James Malcolm on 09/03/2021.
//

import UIKit

class HousesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private let viewModel = HousesViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.addBackground(imageName: "imgHouses")
        tableView.dataSource = viewModel
        viewModel.getData() {_ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
