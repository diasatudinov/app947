//
//  SettingsUIView.swift
//  app947
//
//  Created by Dias Atudinov on 02.10.2024.
//

import SwiftUI

struct SettingsUIView: View {
    @ObservedObject var viewModel: SettingsViewModel
    var body: some View {
        ZStack {
            
            VStack(spacing: 0) {
                HStack {
                    Text("Settings")
                        .font(.system(size: 34, weight: .bold))
                    Spacer()
                }.padding(.top, 40).padding(.bottom, 20)
                
                VStack(spacing: 10) {
                    
                    ZStack {
                        Rectangle()
                            .cornerRadius(12)
                            .foregroundColor(.white)
                            .shadow(radius: 1)
                            .frame(height: 50)
                        HStack {
                            Button {
                                viewModel.rateApp()
                            } label: {
                                HStack(spacing: 14) {
                                    
                                    Image(systemName: "star.square")
                                        .foregroundColor(.black)
                                        .font(.system(size: 17))
                                    
                                    Text("Rate our app")
                                        .foregroundColor(.black)
                                        .font(.system(size: 17, weight: .regular))
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.black)
                                        .font(.system(size: 17))
                                }.padding(14)
                            }
                        }
                    }
                    
                    ZStack {
                        Rectangle()
                            .cornerRadius(12)
                            .foregroundColor(.white)
                            .shadow(radius: 1)
                            .frame(height: 50)
                        HStack {
                            Button {
                                viewModel.openUsagePolicy()
                            } label: {
                                HStack(spacing: 14) {
                                    
                                    Image(systemName: "doc.text.magnifyingglass")
                                        .foregroundColor(.black)
                                        .font(.system(size: 17))
                                    Text("Usage Policy")
                                        .foregroundColor(.black)
                                        .font(.system(size: 16, weight: .regular))
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.black)
                                        .font(.system(size: 17))
                                }.padding(14)
                            }
                        }
                    }
                    
                    
                    ZStack {
                        Rectangle()
                            .cornerRadius(12)
                            .foregroundColor(.white)
                            .shadow(radius: 1)
                            .frame(height: 50)
                        HStack {
                            Button {
                                viewModel.shareApp()
                            } label: {
                                HStack(spacing: 14) {
                                    
                                    Image(systemName: "square.and.arrow.up")
                                        .foregroundColor(.black)
                                        .font(.system(size: 17))
                                    
                                    Text("Share our app")
                                        .foregroundColor(.black)
                                        .font(.system(size: 17, weight: .regular))
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.black)
                                        .font(.system(size: 17))
                                }.padding(14)
                            }
                        }
                    }
                    
                }
                Spacer()
            }.padding(.horizontal)
        }
    }
}

#Preview {
    SettingsUIView(viewModel: SettingsViewModel())
}
