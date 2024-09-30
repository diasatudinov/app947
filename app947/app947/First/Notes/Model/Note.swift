//
//  Note.swift
//  app947
//
//  Created by Dias Atudinov on 30.09.2024.
//

import SwiftUI

struct Note: Hashable, Codable {
    let id = UUID()
    var imageData: Data?
    var name: String
    var location: String
    var date: Date
    var note: String
    
    var image: UIImage? {
        get {
            guard let data = imageData else { return nil }
            return UIImage(data: data)
        }
        set {
            imageData = newValue?.jpegData(compressionQuality: 1.0)
        }
    }
}
