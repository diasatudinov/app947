//
//  NoteViewModel.swift
//  app947
//
//  Created by Dias Atudinov on 30.09.2024.
//

import SwiftUI

class NoteViewModel: ObservableObject {
    
    @Published var notes: [Note] = [Note(name: "Botanical Garden", location: "Russia, Moscow", date: Date(), note: "A unique garden with a variety of plants from all over the world. Ideal place for privacy and quiet walks among nature")] {
        didSet {
            saveNotes()
        }
    }
    
    private let notesFileName = "notes.json"
    
    init() {
        loadNotes()
    }
    
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func notesFilePath() -> URL {
        return getDocumentsDirectory().appendingPathComponent(notesFileName)
    }
    
   
    
    private func saveNotes() {
        DispatchQueue.global().async {
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(self.notes)
                try data.write(to: self.notesFilePath())
            } catch {
                print("Failed to save players: \(error.localizedDescription)")
            }
        }
    }
    
    
    private func loadNotes() {
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: notesFilePath())
            notes = try decoder.decode([Note].self, from: data)
        } catch {
            print("Failed to load players: \(error.localizedDescription)")
        }
    }
    
    
    func addNote(_ note: Note) {
        notes.append(note)
        
    }
    
    func editNote(_ noteOne: Note, image: UIImage?, name: String, location: String, date: Date, note: String) {
        if let index = notes.firstIndex(where: { $0.id == noteOne.id }) {
            notes[index].image = image
            notes[index].name = name
            notes[index].location = location
            notes[index].date = date
            notes[index].note = note
        }
    }
    
    func deleteNote(_ note: Note) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes.remove(at: index)
        }
    }
}
