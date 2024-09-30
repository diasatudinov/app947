//
//  NotesUIView.swift
//  app947
//
//  Created by Dias Atudinov on 30.09.2024.
//

import SwiftUI

struct NotesUIView: View {
    @ObservedObject var viewModel: NoteViewModel
    
    @State var addNote = false
    var body: some View {
        ZStack {
            
            VStack(spacing: 0) {
                HStack {
                    Text("Travelling Notes")
                        .font(.system(size: 34, weight: .bold))
                    Spacer()
                    Button {
                        addNote = true
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
            
            
            if addNote {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color.black.opacity(0.3)).ignoresSafeArea()
                    
                    AddNote(newMemory: $addNote, viewModel: viewModel)
                        .transition(.move(edge: .bottom))
                }
                
                
            
            }
        }
    }
}

#Preview {
    NotesUIView(viewModel: NoteViewModel())
}

struct AddNote: View {
    @Binding var newMemory: Bool
    @ObservedObject var viewModel: NoteViewModel
    
    @State var name = ""
    @State var location = ""
    @State var date: Date = Date()
    @State var note = ""
    @State private var selectedImage: UIImage?
    
    @State var datePickerShow = false
    @State private var isShowingImagePicker = false
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Rectangle()
                    .foregroundColor(.white)
                    .clipShape(RoundedCorner(radius: 13, corners: [.topLeft, .topRight]))
                    .ignoresSafeArea(edges: .bottom)
                    .frame(height: UIScreen.main.bounds.height / 1.15)
                    
                VStack(spacing: 0) {
                    
                    HStack {
                        Button {
                            withAnimation {
                                newMemory = false
                            }
                        } label: {
                            Text("Cancel")
                                .foregroundColor(.secondaryRed)
                                .font(.system(size: 17, weight: .regular))
                        }
                        Spacer()
                        Text("Create a memory")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.black)
                        Spacer()
                        Button {
                            if !name.isEmpty, !location.isEmpty {
                                if let image = selectedImage {
                                    let note = Note(imageData: image.jpegData(compressionQuality: 1.0), name: name, location: location, date: date, note: note)
                                    
                                    viewModel.addNote(note)
                                } else {
                                    
                                    let note = Note(name: name, location: location, date: date, note: note)
                                    viewModel.addNote(note)
                                }
                                withAnimation {
                                    newMemory = false
                                }
                            }
                        } label: {
                            Text("Done")
                                .foregroundColor(.secondaryRed)
                                .font(.system(size: 17, weight: .semibold))
                        }
                    }.padding(.bottom, 11)
                    Rectangle()
                        .foregroundColor(.black.opacity(0.3))
                        .frame(height: 0.33)
                        .padding(.horizontal, -20)
                        .padding(.bottom, 25)
                    VStack(spacing: 15) {
                        
                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 190)
                                .clipShape(RoundedRectangle(cornerRadius: 18))
                                .allowsHitTesting(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)
                        } else {
                            ZStack {
                                Rectangle()
                                    .frame(height: 190)
                                    .cornerRadius(18)
                                    .foregroundColor(.black.opacity(0.1))
                            
                                Image(systemName: "photo")
                                    .font(.system(size: 65))
                                    .foregroundColor(.black.opacity(0.3))
                            }
                        }
                        
                        Text("Pick a picture")
                            .foregroundColor(.secondaryRed)
                            .onTapGesture {
                                isShowingImagePicker = true
                            }
                        
                        ZStack() {
                            
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .shadow(radius: 2)
                            
                            HStack(spacing: 10) {
                                Text("Name")
                                    .foregroundColor(.black)
                                    .font(.system(size: 17, weight: .regular))
                                    .padding(.trailing, -25)
                                TextField("Botanical Garden", text: $name)
                                    .font(.system(size: 17, weight: .regular))
                                    .padding(.leading, 20)
                            }.padding(12).padding(.horizontal, 4)
                            
                        }.frame(height: 46)
                        
                        ZStack {
                            
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .shadow(radius: 2)
                            
                            HStack(spacing: 10) {
                                Text("Location")
                                    .foregroundColor(.black)
                                    .font(.system(size: 17, weight: .regular))
                                    .padding(.trailing, -25)
                                TextField("Russia, Moscow", text: $location)
                                    .font(.system(size: 17, weight: .regular))
                                    .padding(.leading, 20)
                            }.padding(12).padding(.horizontal, 4)
                            
                        }.frame(height: 46)
                        
                        
                        ZStack {
                            
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .shadow(radius: 2)
                            
                            HStack(spacing: 10) {
                                Text("Date")
                                    .foregroundColor(.black)
                                    .font(.system(size: 17, weight: .regular))
                                    .padding(.trailing, -25)
                                Spacer()
                                Text(formattedTime(time: date))
                                    .foregroundColor(.secondaryRed)
                                    .padding(6).padding(.horizontal, 5)
                                    .background(Color.black.opacity(0.05))
                                    .cornerRadius(6)
                                    .onTapGesture {
                                        datePickerShow.toggle()
                                    }
                            }.padding(12).padding(.horizontal, 4)
                            
                        }.frame(height: 46)
                        
                        
                        VStack(alignment: .leading) {
                            Text("Note")
                                .font(.system(size: 13, weight: .regular))
                            TextEditor(text: $note)
                                .font(.system(size: 17, weight: .regular))
                                .padding(12)
                                .frame(maxHeight: 143)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.secondaryRed, lineWidth: 1)
                                )
                        }
                        
                    }
                    Spacer()
                    
                }.padding(20)
                
                if datePickerShow {
                    VStack{
                        Spacer()
                        DatePicker(
                            "Choose your date",
                            selection: $date,
                            displayedComponents: [.date]
                        )
                        .datePickerStyle(.wheel)
                        .labelsHidden()
                        .background(Color.white)
                        
                    }.padding(.bottom, 40)
                }
            }.frame(height: UIScreen.main.bounds.height / 1.15)
        }.sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
            ImagePicker(selectedImage: $selectedImage, isPresented: $isShowingImagePicker)
        }
        
    }
    
    private func formattedTime(time: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        return formatter.string(from: time)
    }
    
    func loadImage() {
        if let selectedImage = selectedImage {
            print("Selected image size: \(selectedImage.size)")
        }
    }
}
