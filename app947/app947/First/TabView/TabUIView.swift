//
//  TabUIView.swift
//  app947
//
//  Created by Dias Atudinov on 30.09.2024.
//

import SwiftUI

struct TabUIView: View {
    @State var selectedTab = 0
    private let tabs = ["Home", "Attractions", "Settings"]
    @ObservedObject var homeVM: HomeViewModel = HomeViewModel()
    @ObservedObject var notesVM: NoteViewModel = NoteViewModel()
    @ObservedObject var settingsVM = SettingsViewModel()
    var body: some View {
        ZStack {
            
            switch selectedTab {
            case 0:
                HomeUIView(viewModel: homeVM)
            case 1:
                NotesUIView(viewModel: notesVM)
            case 2:
               SettingsUIView(viewModel: settingsVM)
            default:
                Text("default")
            }
                VStack {
                    Spacer()
                    
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundColor(.black.opacity(0.5))
                    ZStack {
                        Rectangle()
                            .fill(Color.white)
                            .frame(height: 83)
                            .blur(radius: 5)
                            
                        HStack(spacing: 66) {
                            ForEach(0..<tabs.count) { index in
                                Button(action: {
                                    selectedTab = index
                                }) {
                                    
                                    ZStack {
                                        VStack {
                                            Image(systemName: icon(for: index))
                                                .font(.system(size: 20, weight: .semibold))
                                                .padding(.bottom, 2)
                                            Text(text(for: index))
                                                .font(.system(size: 10, weight: .medium))
                                        }.foregroundColor(selectedTab == index ? Color.secondaryRed : Color.black.opacity(0.3))
                                    }
                                }
                                
                            }
                        }.padding(.bottom, 15)
                    
                    }
                    
                }.ignoresSafeArea()
            
        }
    }
    
    private func icon(for index: Int) -> String {
        switch index {
        case 0: return "house"
        case 1: return "map"
        case 2: return "gearshape"
        default: return ""
        }
    }
    
    private func text(for index: Int) -> String {
        switch index {
        case 0: return "Home"
        case 1: return "Travelling Notes"
        case 2: return "Settings"
        default: return ""
        }
    }
}

#Preview {
    TabUIView()
}
