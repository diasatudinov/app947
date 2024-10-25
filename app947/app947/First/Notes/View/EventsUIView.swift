//
//  EventsUIView.swift
//  app947
//
//  Created by Dias Atudinov on 25.10.2024.
//

import SwiftUI

struct EventsUIView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel: NoteViewModel
    @State private var addEvent = false
    @State private var editEvent = false
    @State var selectedStory: Story?
    var progress: Double {
        Double(viewModel.events.count) / 25 // Вычисляем прогресс
    }
    var body: some View {
        ZStack {
            
            VStack(spacing: 0) {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.left")
                            
                            Text("Back")
                        }.foregroundColor(.secondaryRed)
                    }
                    Spacer()
                    
                }.padding(.bottom, 10)
                HStack {
                    Text("Event")
                        .font(.system(size: 34, weight: .bold))
                    Spacer()
                }.padding(.bottom, 20)
                
                ZStack {
                    Color.black.opacity(0.05)
                    
                    VStack {
                        HStack {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Travelling to China")
                                        .font(.system(size: 20, weight: .semibold))
                                    Image(.arch)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 18)
                                }
                                Text("Valid until November 25, 2024")
                                    .font(.system(size: 11, weight: .regular))
                                    .foregroundColor(.black.opacity(0.5))
                            }
                            Spacer()
                            
                        }.padding(.bottom, 30)
                        
                        VStack {
                            HStack {
                                Text("\(viewModel.events.count)")
                                    .font(.system(size: 17, weight: .semibold))
                                    .foregroundColor(.mainRed)
                                Spacer()
                                Text("25")
                                    .font(.system(size: 17, weight: .semibold))
                                    .foregroundColor(.black)
                                
                            }
                            ProgressView(value: progress, total: 1)
                                .progressViewStyle(LinearProgressViewStyle())
                                .accentColor(.mainRed)
                                .scaleEffect(y: 2.5, anchor: .center)
                            HStack {
                                Text("There are notes left")
                                    .font(.system(size: 13, weight: .regular))
                                    .foregroundColor(.black.opacity(0.7))
                                Spacer()
                                Text("Necessary")
                                    .font(.system(size: 13, weight: .regular))
                                    .foregroundColor(.black.opacity(0.7))
                            }
                        }
                        Spacer()
                    }.padding().padding(.vertical, 4)
                }.frame(height: 159).cornerRadius(16).padding(.bottom, 20)
                
                HStack {
                    Text("Stories")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.black)
                    Spacer()
                    Button {
                        withAnimation {
                            addEvent = true
                        }
                    } label: {
                        Text("Add a story")
                            .foregroundColor(.secondaryRed)
                    }
                }.padding(.bottom, 10)
                
                if viewModel.events.isEmpty {
                    VStack(spacing: 0) {
                        Text("Empty")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.black)
                            .padding(.bottom, 8)
                        Text("You don't have any stories added yet")
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(.black.opacity(0.7))
                            .padding(.bottom, 20)
                        Button {
                            withAnimation {
                                addEvent = true
                            }
                        } label: {
                            
                            ZStack {
                                Color.secondaryRed
                                Text("New")
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundColor(.white)
                                
                            }.frame(width: 100, height: 42).cornerRadius(10)
                        }
                        
                    }.padding(.top, 70)
                    Spacer()
                } else {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 8) {
                            ForEach(viewModel.events, id: \.self) { event in
                                
                                EventCell(story: event,
                                          onEdit: {
                                    selectedStory = event
                                    editEvent = true
                                }, onDelete: {
                                    viewModel.removeStory(id: event.id)
                                })
                                
                            }
                        }
                    }
                }
            }.padding(.horizontal)
            
            if addEvent {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color.black.opacity(0.3)).ignoresSafeArea()
                    
                    AddEvent(newMemory: $addEvent, viewModel: viewModel)
                        .transition(.move(edge: .bottom))
                }
            }
            
            if editEvent {
                if let selectedStory = selectedStory {
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color.black.opacity(0.3)).ignoresSafeArea()
                        
                        EditEvent(newMemory: $editEvent, viewModel: viewModel, story: selectedStory)
                            .transition(.move(edge: .bottom))
                    }
                }
            }
        }
    }
}

#Preview {
    EventsUIView(viewModel: NoteViewModel())
}

struct AddEvent: View {
    @Binding var newMemory: Bool
    @ObservedObject var viewModel: NoteViewModel
    
    @State var name = ""
    @State var note = ""
    
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
                        Text("Add a story")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.black)
                        Spacer()
                        Button {
                            if !name.isEmpty, !note.isEmpty {
                                
                                
                                
                                let story = Story(number: viewModel.events.count + 1, name: name, note: name)
                                viewModel.addStory(story)
                                
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
                        
                        ZStack() {
                            
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .shadow(radius: 2)
                            
                            HStack(spacing: 4) {
                                Text("№")
                                    .foregroundColor(.black)
                                    .font(.system(size: 17, weight: .regular))
                                Text("\(viewModel.events.count + 1)")
                                
                                Spacer()
                            }.padding(12).padding(.horizontal, 4)
                            
                        }.frame(height: 46)
                        
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
                                TextField("Great Wall of China", text: $name)
                                    .font(.system(size: 17, weight: .regular))
                                    .padding(.leading, 20)
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
                
            }.frame(height: UIScreen.main.bounds.height / 2.2)
        }
        
    }
}

struct EditEvent: View {
    @Binding var newMemory: Bool
    @ObservedObject var viewModel: NoteViewModel
    @State var story: Story
    @State var number = 0
    @State var name = ""
    @State var note = ""
    
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
                        Text("Edit a story")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.black)
                        Spacer()
                        Button {
                            if !name.isEmpty, !note.isEmpty {
                                
                                viewModel.editStory(story, newName: name, newNote: note)
                                
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
                        
                        ZStack() {
                            
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .shadow(radius: 2)
                            
                            HStack(spacing: 4) {
                                Text("№")
                                    .foregroundColor(.black)
                                    .font(.system(size: 17, weight: .regular))
                                Text("\(number)")
                                
                                Spacer()
                            }.padding(12).padding(.horizontal, 4)
                            
                        }.frame(height: 46)
                        
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
                                TextField("Great Wall of China", text: $name)
                                    .font(.system(size: 17, weight: .regular))
                                    .padding(.leading, 20)
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
                
            }.frame(height: UIScreen.main.bounds.height / 2.2)
                .onAppear{
                    number = story.number
                    name = story.name
                    note = story.note
                }
        }
        
    }
}
