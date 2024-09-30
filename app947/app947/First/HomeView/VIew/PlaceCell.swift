//
//  HomeCell.swift
//  app947
//
//  Created by Dias Atudinov on 26.09.2024.
//

import SwiftUI

struct PlaceCell: View {
    @ObservedObject var viewModel: HomeViewModel
    @State var place: Place
    
    let onEdit: () -> Void
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .top) {
                    
                    HStack {
                        Image(systemName: "calendar")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                        Text("\(formattedTime(time: place.date))")
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                    }.padding(4).padding(.horizontal, 6).background(Color.secondaryRed).cornerRadius(6)
                    
                    HStack {
                        Image(systemName: "star.circle.fill")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                        Text("\(String(format: "%.1f",place.grade))")
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                    }.padding(4).padding(.horizontal, 6).background(Color.secondaryRed).cornerRadius(6)
                    
                    Spacer()
                    
                    Menu {
                        Button(action: {
                            // Действие для редактирования
                            onEdit()
                        }) {
                            Label("Edit", systemImage: "pencil")
                        }
                        
                        Button(action: {
                            // Действие для удаления
                            withAnimation {
                                viewModel.deletePlace(place)
                            }
                        }) {
                            Label("Delete", systemImage: "trash")
                        }
                    } label:{
                        Image(systemName: "ellipsis.circle")
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                    }
                }
                
                Text(place.name)
                    .foregroundColor(.black)
                    .font(.system(size: 17, weight: .semibold))
                
                Text(place.note)
                    .foregroundColor(.black.opacity(0.7))
                    .font(.system(size: 15, weight: .regular))
                Spacer()
            }.padding()
        }
        .frame(height: 157)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.secondaryRed, lineWidth: 1)
        )
    }
    
    private func formattedTime(time: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: time)
    }
}

#Preview {
    PlaceCell(viewModel: HomeViewModel(), place: Place(name: "Sunny Park", grade: 4.9, date: Date(), note: "Cosy city park with green alleys and water bodies, an ideal place for walks and picnics with friends"), onEdit: {
        
    })
}
