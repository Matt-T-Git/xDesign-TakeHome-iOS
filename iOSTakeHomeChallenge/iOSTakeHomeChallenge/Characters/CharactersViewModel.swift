//
//  CharactersViewModel.swift
//  iOSTakeHomeChallenge
//
//  Created by Matt Thomas on 19/05/2021.
//

import UIKit

class CharactersViewModel: NSObject, UITableViewDataSource {
    
    private var cachedCharacters: [Character] = []
    private let network = Network()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cachedCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell") as! CharacterTableViewCell
        cell.setupWith(character: cachedCharacters[indexPath.row])
        return cell
    }
    
    func getData(completionHandler: @escaping (Bool) -> Void) {
        network.makeRequest(url: URL(string: network.baseURL.appending(Endpoint.characters))!, type: [Character].self, completionHandler: { [self] error, characters in
            if let characters = characters {
                cachedCharacters = characters
                completionHandler(true)
            }
        })
    }
}
