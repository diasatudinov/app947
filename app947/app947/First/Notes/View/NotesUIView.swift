//
//  NotesUIView.swift
//  app947
//
//  Created by Dias Atudinov on 30.09.2024.
//

import SwiftUI

struct NotesUIView: View {
    @ObservedObject var viewModel: NoteViewModel
    var body: some View {
        ZStack {
            
            VStack(spacing: 0) {
                HStack {
                    Text("Travelling Notes")
                        .font(.system(size: 34, weight: .bold))
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 24))
                            .foregroundColor(.secondaryRed)
                    }
                }.padding(.top, 40).padding(.bottom, 20)
                
                ScrollView(showsIndicators: false) {
                    
                    ForEach( viewModel.notes, id: \.self) { note in
                        NoteCell(viewModel: viewModel, note: note, onEdit: {
                            //selectedPlace = place
                            //editMemory = true
                        })
                        
                    }
                }
                Spacer()
            }.padding(.horizontal)
        }
    }
}

#Preview {
    NotesUIView(viewModel: NoteViewModel())
}
