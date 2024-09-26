//
//  HomeUIView.swift
//  app947
//
//  Created by Dias Atudinov on 26.09.2024.
//

import SwiftUI

struct HomeUIView: View {
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
                        HomeCell(text: "You've visited countries", count: 48)
                        HomeCell(text: "You've visited countries", count: 48)
                    }
                    
                    HStack{
                        HomeCell(text: "You've visited countries", count: 48)
                        HomeCell(text: "You've visited countries", count: 48)
                    }
                }.padding(.bottom, 10)
                
                Button {
                    
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
                        
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.mainRed)
                            .font(.system(size: 20))
                    }
                }
                
                ScrollView {
                    
                }
                Spacer()
            }.padding(.horizontal)
        }
    }
}

#Preview {
    HomeUIView()
}

struct HomeCell: View {
    @State var text: String
    @State var count: Int
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
