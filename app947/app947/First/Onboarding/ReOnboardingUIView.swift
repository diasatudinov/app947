//
//  ReOnboardingUIView.swift
//  app947
//
//  Created by Dias Atudinov on 25.09.2024.
//

import SwiftUI

struct ReOnboardingUIView: View {
    @State private var pageNum: Int = 1
    @State private var showSheet = false
    @AppStorage("signedUP") var signedUP: Bool = false

    var body: some View {
        if !signedUP {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.gradientTop, .gradientBottom]),
                               startPoint: .top,
                               endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
                VStack(spacing: 0) {
                    
                    switch pageNum {
                    case 1: Image("app947Screen1")
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width - 80)
                            .padding(.top, 30)
                            
                    case 2: Image("app947Screen2")
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width - 80)
                            .padding(.top, 30)
                    case 3: Image("app947Screen3")
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width - 80)
                            .padding(.top, 30)
                    default:
                        Image("appScreen3")
                            .resizable()
                            .frame(height: 549)
                            .ignoresSafeArea()
                    }
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(.mainRed)
                            .cornerRadius(30)
                        
                        VStack {
                            switch pageNum {
                            case 1:
                                VStack(spacing: 12) {
                                    Text("Capture your adventures!")
                                        .font(.title)
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                        .multilineTextAlignment(.center)
                                    Text("Travelling? Don't forget to save every vivid \ndetail! An app that helps you capture \nmemories of the places you've visited")
                                        .font(.system(size: 15))
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.white.opacity(0.7))
                                }.frame(height: 100).padding(.bottom, 10).padding(.horizontal, 30).foregroundColor(.white).padding(.top, 24).padding(.bottom, 39)
                            case 2:
                                VStack(spacing: 12) {
                                    Text("Write down your impressions")
                                        .font(.title)
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                        .multilineTextAlignment(.center)
                                    Text("Fill in handy notes with descriptions, \nimpressions and tips to make it easy \nto remember what you liked in the future")
                                        .font(.system(size: 15))
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.white.opacity(0.7))
                                }.frame(height: 100).padding(.bottom, 10).foregroundColor(.white).padding(.top, 24).padding(.bottom, 39)
                            case 3:
                                VStack(spacing: 12) {
                                    Text("Modify your notes")
                                        .font(.title)
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                        .multilineTextAlignment(.center)
                                    Text("Edit your travel notes easily with our app.\nAlso don't forget to insert a photo \nof your journey.")
                                        .font(.system(size: 15))
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.white.opacity(0.7))
                                }.frame(height: 100).padding(.bottom, 10).foregroundColor(.white).padding(.top, 24).padding(.bottom, 39)
                            default:
                                Text("Save information about \nyour favorite routes")
                                    .font(.title)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .frame(height: 70)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                                    .padding(.bottom, 10)
                                
                            }
                            
                            Button {
                                if pageNum < 3 {
                                    pageNum += 1
                                } else {
                                    signedUP = true
                                }
                            } label: {
                                Text("Next")
                                    .foregroundColor(Color.mainRed)
                                    .font(.system(size: 20, weight: .semibold))
                                    .padding()
                                    .frame(maxWidth: .infinity)
                            }.frame(height: 60).background(Color.white)
                                .cornerRadius(35).padding(.horizontal)
                            
                            HStack(spacing: 8) {
                                Circle()
                                    .fill(pageNum == 1 ? Color.white : Color.white.opacity(0.5))
                                    .frame(width: 8, height: 8)
                                    .cornerRadius(19)
                                
                                Circle()
                                    .fill(pageNum == 2 ? Color.white : Color.white.opacity(0.5))
                                    .frame(width: 8, height: 8)
                                    .cornerRadius(19)
                                
                                Circle()
                                    .fill(pageNum == 3 ? Color.white : Color.white.opacity(0.5))
                                    .frame(width: 8, height: 8)
                                    .cornerRadius(19)
                            }
                            .padding()
                            
                        }
                        
                    }
                    
                    
                }.edgesIgnoringSafeArea(.bottom)
            }
            
        } else {
            TabUIView()
        }
    }
    }


#Preview {
    ReOnboardingUIView()
}
