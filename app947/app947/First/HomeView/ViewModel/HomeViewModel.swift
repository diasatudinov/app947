//
//  HomeViewModel.swift
//  app947
//
//  Created by Dias Atudinov on 27.09.2024.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var homeInfo: HomeInfo = HomeInfo(visited: 0, newFriendships: 0, newDishes: 0, excursions: 0) {
        didSet {
            saveInfo()
        }
    }
    
    @Published var places: [Place] = [] {
        didSet {
            savePlaces()
        }
    }
    
    private let placesFileName = "places.json"
    private let infoFileName = "info.json"

    init() {
        loadPlaces()
        loadInfo()
    }
    
    
    func changeData(_ info: HomeInfo) {
        homeInfo = info
    }
    
    func createPlace(_ place: Place) {
        places.append(place)
    }
    
    func editPlace(_ place: Place, name: String, grade: Double, date: Date, note: String) {
        if let index = places.firstIndex(where: { $0.id == place.id }) {
            places[index].name = name
            places[index].grade = grade
            places[index].date = date
            places[index].note = note
        }
    }
    
    func deletePlace(_ place: Place) {
        if let index = places.firstIndex(where: { $0.id == place.id }) {
            places.remove(at: index)
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func placesFilePath() -> URL {
        return getDocumentsDirectory().appendingPathComponent(placesFileName)
    }
    
   
    
    private func savePlaces() {
        DispatchQueue.global().async {
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(self.places)
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
            places = try decoder.decode([Place].self, from: data)
        } catch {
            print("Failed to load players: \(error.localizedDescription)")
        }
    }
    
    
    private func infoFilePath() -> URL {
        return getDocumentsDirectory().appendingPathComponent(infoFileName)
    }
    
   
    
    private func saveInfo() {
        DispatchQueue.global().async {
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(self.homeInfo)
                try data.write(to: self.infoFilePath())
            } catch {
                print("Failed to save players: \(error.localizedDescription)")
            }
        }
    }
    
    
    private func loadInfo() {
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: infoFilePath())
            homeInfo = try decoder.decode(HomeInfo.self, from: data)
        } catch {
            print("Failed to load players: \(error.localizedDescription)")
        }
    }
    
}
