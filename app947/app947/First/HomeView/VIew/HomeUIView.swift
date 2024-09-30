//
//  HomeUIView.swift
//  app947
//
//  Created by Dias Atudinov on 26.09.2024.
//

import SwiftUI

struct HomeUIView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State var selectedPlace: Place?
    
    @State var editStats = false
    @State var newMemory = false
    @State var editMemory = false
    var body: some View {
        ZStack {
            
            VStack(spacing: 0) {
                HStack {
                    Text("Home")
                        .font(.system(size: 34, weight: .bold))
                    Spacer()
                }.padding(.top, 40).padding(.bottom, 20)
                
                VStack {
                    HStack{
                        HomeCell(text: "You've visited countries", count: $viewModel.homeInfo.visited)
                        HomeCell(text: "New friendships", count: $viewModel.homeInfo.newFriendships)
                    }
                    
                    HStack{
                        HomeCell(text: "Tried some new dishes", count: $viewModel.homeInfo.newDishes)
                        HomeCell(text: "We went on excursions", count: $viewModel.homeInfo.excursions)
                    }
                }.padding(.bottom, 10)
                
                Button {
                    withAnimation {
                        editStats = true
                    }
                } label: {
                    ZStack {
                        Rectangle()
                            .frame(height: 52)
                            .foregroundColor(.mainRed)
                            .cornerRadius(16)
                        Text("Edit")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.white)
                        
                        
                    }
                }.padding(.bottom, 25)
                
                HStack {
                    Text("My favourite places")
                        .font(.system(size: 22, weight: .bold))
                    Spacer()
                    Button {
                        newMemory = true
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.mainRed)
                            .font(.system(size: 20))
                    }
                }.padding(.bottom, 15)
                
                ScrollView(showsIndicators: false) {
                    
                    ForEach( viewModel.places, id: \.self) { place in
                        PlaceCell(viewModel: viewModel, place: place, onEdit: {
                            selectedPlace = place
                            editMemory = true
                        })
                    }
                }
                Spacer()
            }.padding(.horizontal)
            
            
            if editStats {
                
                ZStack {
                    Rectangle()
                        .foregroundColor(Color.black.opacity(0.3)).ignoresSafeArea()
                    EditStats(editStats: $editStats, info: viewModel.homeInfo, viewModel: viewModel)
                        .transition(.move(edge: .bottom))
                }
                
                
            }
            
            if newMemory {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color.black.opacity(0.3)).ignoresSafeArea()
                    NewMemory(newMemory: $newMemory, viewModel: viewModel)
                        .transition(.move(edge: .bottom))
                }
                
                
            }
            
            if editMemory {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color.black.opacity(0.3)).ignoresSafeArea()
                    if let selectedPlace = selectedPlace {
                        EditMemory(newMemory: $editMemory, viewModel: viewModel, place: .constant(selectedPlace))
                            .transition(.move(edge: .bottom))
                    }
                }
            }
            
        }.padding(.bottom, 50)
    }
}

#Preview {
    HomeUIView(viewModel: HomeViewModel())
}

struct HomeCell: View {
    @State var text: String
    @Binding var count: Int
    var body: some View {
        ZStack {
            Color.black.opacity(0.05)
            VStack(alignment: .leading){
                HStack {
                    Text(text)
                        .font(.system(size: 20, weight: .semibold))
                    Spacer()
                }
                
                Text("\(count)")
                    .font(.system(size: 34, weight: .bold))
                
            }.padding(.horizontal)
        }.cornerRadius(16).frame(height: 131)
    }
}

struct EditStats: View {
    @Binding var editStats: Bool
    @State var info: HomeInfo
    @ObservedObject var viewModel: HomeViewModel
    
    @State var visited = ""
    @State var newFriendships = ""
    @State var newDishes = ""
    @State var excursions = ""
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Rectangle()
                    .foregroundColor(.white)
                    .clipShape(RoundedCorner(radius: 13, corners: [.topLeft, .topRight]))
                    .ignoresSafeArea(edges: .bottom)
                    .frame(height: UIScreen.main.bounds.height / 2.25)
                    .onAppear {
                        
                        visited = "\(info.visited)"
                        newFriendships = "\(info.newFriendships)"
                        newDishes = "\(info.newDishes)"
                        excursions = "\(info.excursions)"
                    }
                VStack(spacing: 0) {
                    
                    HStack {
                        Button {
                            withAnimation {
                                editStats = false
                            }
                        } label: {
                            Text("Cancel")
                                .foregroundColor(.secondaryRed)
                                .font(.system(size: 17, weight: .regular))
                        }
                        Spacer()
                        Text("Edit statistic")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.black)
                        Spacer()
                        Button {
                            if let visited = Int(visited), let newFriendships = Int(newFriendships), let newDishes = Int(newDishes), let excursions = Int(excursions) {
                                viewModel.changeData(HomeInfo(visited: visited, newFriendships: newFriendships, newDishes: newDishes, excursions: excursions))
                                withAnimation {
                                    editStats = false
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
                            
                            HStack(spacing: 10) {
                                Text("You've visited countries")
                                    .foregroundColor(.black)
                                    .font(.system(size: 17, weight: .regular))
                                    .padding(.trailing, -25)
                                TextField("", text: $visited)
                                    .keyboardType(.numberPad)
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
                                Text("New friendships")
                                    .foregroundColor(.black)
                                    .font(.system(size: 17, weight: .regular))
                                    .padding(.trailing, -25)
                                TextField("", text: $newFriendships)
                                    .keyboardType(.numberPad)
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
                                Text("Tried some new dishes")
                                    .foregroundColor(.black)
                                    .font(.system(size: 17, weight: .regular))
                                    .padding(.trailing, -25)
                                TextField("", text: $newDishes)
                                    .keyboardType(.numberPad)
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
                                Text("We went on excursions")
                                    .foregroundColor(.black)
                                    .font(.system(size: 17, weight: .regular))
                                    .padding(.trailing, -25)
                                TextField("", text: $excursions)
                                    .keyboardType(.numberPad)
                                    .font(.system(size: 17, weight: .regular))
                                    .padding(.leading, 20)
                            }.padding(12).padding(.horizontal, 4)
                            
                        }.frame(height: 46)
                        
                    }
                    Spacer()
                    
                }.padding(20)
            }.frame(height: UIScreen.main.bounds.height / 2.25)
        }
        
    }
}

struct NewMemory: View {
    @Binding var newMemory: Bool
    @ObservedObject var viewModel: HomeViewModel
    
    @State var name = ""
    @State var grade = ""
    @State var date: Date = Date()
    @State var note = ""
    
    @State var datePickerShow = false
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Rectangle()
                    .foregroundColor(.white)
                    .clipShape(RoundedCorner(radius: 13, corners: [.topLeft, .topRight]))
                    .ignoresSafeArea(edges: .bottom)
                    .frame(height: UIScreen.main.bounds.height / 1.7)
                    
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
                            if !name.isEmpty, !grade.isEmpty {
                                let place = Place(name: name, grade: Double(grade.replacingOccurrences(of: ",", with: ".")) ?? 0.0, date: date, note: note)
                                viewModel.createPlace(place)
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
                            
                            HStack(spacing: 10) {
                                Text("Name")
                                    .foregroundColor(.black)
                                    .font(.system(size: 17, weight: .regular))
                                    .padding(.trailing, -25)
                                TextField("Sunny Park", text: $name)
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
                                Text("Grade")
                                    .foregroundColor(.black)
                                    .font(.system(size: 17, weight: .regular))
                                    .padding(.trailing, -25)
                                TextField("4.9", text: $grade)
                                    .keyboardType(.decimalPad)
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
            }.frame(height: UIScreen.main.bounds.height / 1.7)
        }
        
    }
    
    private func formattedTime(time: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        return formatter.string(from: time)
    }
}


struct EditMemory: View {
    @Binding var newMemory: Bool
    @ObservedObject var viewModel: HomeViewModel
    @Binding var place: Place
    
    @State var name = ""
    @State var grade = ""
    @State var date: Date = Date()
    @State var note = ""
    
    @State var datePickerShow = false
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Rectangle()
                    .foregroundColor(.white)
                    .clipShape(RoundedCorner(radius: 13, corners: [.topLeft, .topRight]))
                    .ignoresSafeArea(edges: .bottom)
                    .frame(height: UIScreen.main.bounds.height / 1.7)
                    
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
                            if !name.isEmpty, !grade.isEmpty {
                                viewModel.editPlace(place, name: name, grade: Double(grade.replacingOccurrences(of: ",", with: ".")) ?? 0.0, date: date, note: note)
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
                            
                            HStack(spacing: 10) {
                                Text("Name")
                                    .foregroundColor(.black)
                                    .font(.system(size: 17, weight: .regular))
                                    .padding(.trailing, -25)
                                TextField("Sunny Park", text: $name)
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
                                Text("Grade")
                                    .foregroundColor(.black)
                                    .font(.system(size: 17, weight: .regular))
                                    .padding(.trailing, -25)
                                TextField("4.9", text: $grade)
                                    .keyboardType(.decimalPad)
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
            }.frame(height: UIScreen.main.bounds.height / 1.7)
                .onAppear {
                    name = place.name
                    grade = "\(place.grade)"
                    date = place.date
                    note = place.note
                    
                }
        }
        
    }
    
    private func formattedTime(time: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        return formatter.string(from: time)
    }
}


struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
