//
//  NoteViewModel.swift
//  app947
//
//  Created by Dias Atudinov on 30.09.2024.
//

import Foundation

class NoteViewModel: ObservableObject {
    
    @Published var notes: [Note] = [Note(name: "Botanical Garden", location: "Russia, Moscow", date: Date(), note: "A unique garden with a variety of plants from all over the world. Ideal place for privacy and quiet walks among nature")]
}
