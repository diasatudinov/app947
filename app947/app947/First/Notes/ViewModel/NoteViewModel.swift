//
//  NoteViewModel.swift
//  app947
//
//  Created by Dias Atudinov on 30.09.2024.
//

import SwiftUI

class NoteViewModel: ObservableObject {
    
    @Published var notes: [Note] = [] {
        didSet {
            saveNotes()
        }
    }
    
    @Published var events: [Story] = [
    ] {
        didSet {
            savePlaces()
        }
    }
    
    
    private let notesFileName = "notes.json"
    private let placesFileName = "categories.json"

    init() {
        loadNotes()
        loadPlaces()

    }
    
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func notesFilePath() -> URL {
        return getDocumentsDirectory().appendingPathComponent(notesFileName)
    }
    
    private func placesFilePath() -> URL {
        return getDocumentsDirectory().appendingPathComponent(placesFileName)
    }
    
    private func savePlaces() {
        DispatchQueue.global().async {
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(self.events)
                try data.write(to: self.placesFilePath())
            } catch {
                print("Failed to save players: \(error.localizedDescription)")
            }
        }
    }
    
    
    private func loadPlaces() {
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: placesFilePath())
            events = try decoder.decode([Story].self, from: data)
        } catch {
            print("Failed to load players: \(error.localizedDescription)")
        }
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
    
    func addStory(_ newStory: Story) {
        events.append(newStory)
    }
    
    func editStory(_ story: Story, newName: String, newNote: String) {
        if let index = events.firstIndex(where: { $0.id == story.id }) {
            events[index].name = newName
            events[index].note = newNote
        }
    }
    
    // Функция для удаления истории
    func removeStory(id: UUID) {
        // Удаляем историю с указанным id
        if let index = events.firstIndex(where: { $0.id == id }) {
            events.remove(at: index)
            
            // Перенумеровываем оставшиеся истории
            for i in 0..<events.count {
                events[i].number = i + 1
            }
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
