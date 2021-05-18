//
//  Models.swift
//  iOSTakeHomeChallenge
//
//  Created by Matt Thomas on 18/05/2021.
//

import Foundation

//MARK: - Book
struct Book: Codable {
    let url: String
    let name: String
    let isbn: String
    let authors: [String]
    let numberOfPages: Int
    let publisher: String
    let country: String
    let mediaType: String
    let released: String
    let characters: [String]
}

//MARK: - House
struct House: Codable {
    let url: String
    let name: String
    let region: String
    let coatOfArms: String
    let words: String
    let titles: [String]
    let seats: [String]
    let currentLord: String
    let heir: String
    let overlord: String
    let founded: String
    let founder: String
    let diedOut: String
    let ancestralWeapons: [String]
    let cadetBranches: [String]
    let swornMembers: [String]
}

//MARK: - Character
struct Character: Codable {
    let url: String
    let name: String
    let gender: String
    let culture: String
    let born: String
    let died: String
    let aliases:  [String]
    let father: String
    let mother: String
    let spouse: String
    let allegiances: [String]
    let books: [String]
    let povBooks: [String]
    let tvSeries: [String]
    let playedBy: [String]
}
