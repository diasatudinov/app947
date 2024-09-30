//
//  HomeModels.swift
//  app947
//
//  Created by Dias Atudinov on 26.09.2024.
//

import Foundation

struct HomeInfo: Codable {
    let id = UUID()
    var visited: Int
    var newFriendships: Int
    var newDishes: Int
    var excursions: Int
}

struct Place: Hashable, Codable {
    let id = UUID()
    var name: String
    var grade: Double
    var date: Date
    var note: String
}
