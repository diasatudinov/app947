//
//  NoteCell.swift
//  app947
//
//  Created by Dias Atudinov on 30.09.2024.
//

import SwiftUI

struct NoteCell: View {
    @ObservedObject var viewModel: NoteViewModel
    @State var note: Note
    
    let onEdit: () -> Void
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 15) {
                
                if let image = note.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 190)
                        .cornerRadius(18)
                        .padding(.horizontal, -16)
                } else {
                    Rectangle()
                        .frame(height: 190)
                        .cornerRadius(18)
                        .foregroundColor(.black.opacity(0.1))
                        .padding(.horizontal, -16)
                }
                
                HStack(alignment: .top) {
                    
                    HStack {
                        Image(systemName: "calendar")
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                        Text("\(formattedTime(time: note.date))")
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
                                viewModel.deleteNote(note)
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
                
                Text(note.name)
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .semibold))
                
                Text(note.note)
                    .foregroundColor(.black.opacity(0.7))
                    .font(.system(size: 15, weight: .regular))
                
                HStack {
                    Image(systemName: "location.fill")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.secondaryRed)
                    Text(note.location)
                        .font(.system(size: 15, weight: .regular))
                }
                Spacer()
            }.padding(.horizontal)
           
        }
        .frame(height: 385)
        .background(Color.black.opacity(0.05))
        .cornerRadius(16)
        
    }
    
    private func formattedTime(time: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: time)
    }
}

#Preview {
    NoteCell(viewModel: NoteViewModel(), note: Note(name: "Botanical Garden", location: "Russia, Moscow", date: Date(), note: "A unique garden with a variety of plants from all over the world. Ideal place for privacy and quiet walks among nature"), onEdit: {})
}
