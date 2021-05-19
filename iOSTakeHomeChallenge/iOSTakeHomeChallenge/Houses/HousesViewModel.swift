//
//  HousesViewModel.swift
//  iOSTakeHomeChallenge
//
//  Created by Matt Thomas on 19/05/2021.
//

import UIKit

class HousesViewModel: NSObject, UITableViewDataSource {
    
    private var cachedHouses: [House] = []
    private let network = Network()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cachedHouses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HouseTableViewCell") as! HouseTableViewCell
        cell.setupWith(house: cachedHouses[indexPath.row])
        return cell
    }

    func getData(completionHandler: @escaping (Bool) -> Void) {
        network.makeRequest(url: URL(string: network.baseURL.appending(Endpoint.houses))!, type: [House].self, completionHandler: { [self] error, houses in
            if let houses = houses {
                cachedHouses = houses
                completionHandler(true)
            }
        })
    }
}
