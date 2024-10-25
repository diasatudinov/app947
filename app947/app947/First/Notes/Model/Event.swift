//
//  Event.swift
//  app947
//
//  Created by Dias Atudinov on 25.10.2024.
//

import Foundation

struct Story: Hashable, Codable {
    var id = UUID()
    var number: Int
    var name: String
    var note: String
}
