//
//  EventCell.swift
//  app947
//
//  Created by Dias Atudinov on 25.10.2024.
//

import SwiftUI

struct EventCell: View {
    
    @State var story: Story
    let onEdit: () -> Void
    let onDelete: () -> Void
    var body: some View {
        ZStack {
            Color.black.opacity(0.05)
            
            VStack {
                HStack {
                    Text("№ \(story.number)")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.white)
                        .padding(5).padding(.horizontal, 5)
                        .background(Color.secondaryRed)
                        .cornerRadius(6)
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
                            onDelete()
                        }) {
                            Label("Delete", systemImage: "trash")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .font(.system(size: 20, weight: .regular))
                            .foregroundColor(.black)
                    }
                }.padding(.bottom, 15)
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    Text(story.name)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.black)
                    Text(story.note)
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(.black.opacity(0.7))
                    
                }
                Spacer()
            }.padding().padding(.vertical, 4)
        }.frame(height: 225).cornerRadius(16)
    }
}

#Preview {
    EventCell(story: Story(number: 1, name: "Great Wall of China", note: "Is one of the grandest structures in the history of mankind. It is more than 21,000 kilometres long and was built over several centuries. According to legend, if the Great Wall of China could fit into a box, it could be placed on the territory of China."), onEdit: {}, onDelete: {})
}
