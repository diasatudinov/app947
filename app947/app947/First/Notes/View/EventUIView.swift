//
//  EventUIView.swift
//  app947
//
//  Created by Dias Atudinov on 25.10.2024.
//

import SwiftUI

struct EventUIView: View {
    @Binding var eventShow: Bool
    @ObservedObject var viewModel: NoteViewModel
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
                    ZStack {
                        HStack {
                            Spacer()
                            Text("Tiger Event")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.black)
                            Spacer()
                        }
                        HStack {
                            Button {
                                withAnimation {
                                    eventShow = false
                                }
                            } label: {
                                Text("Cancel")
                                    .foregroundColor(.secondaryRed)
                                    .font(.system(size: 17, weight: .regular))
                            }
                            Spacer()
                            
                            
                        }
                    }.padding(.bottom, 11)
                    Rectangle()
                        .foregroundColor(.black.opacity(0.3))
                        .frame(height: 0.33)
                        .padding(.horizontal, -20)
                        .padding(.bottom, 5)
                    VStack(spacing: 20) {
                        
                        Image(.event)
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width )
                            .allowsHitTesting(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)
                            .padding(.horizontal, -16)
                        
                        VStack(spacing: 8) {
                            Text("Discover China")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(.mainRed)
                            
                            Text("We invite you to take part in a unique event dedicated to the culture and history of China!")
                                .font(.system(size: 17, weight: .regular))
                                .foregroundColor(.black)
                        }
                        
                        ZStack {
                            
                            VStack(spacing: 8) {
                                Text("Description")
                                    .font(.system(size: 17, weight: .medium))
                                    .foregroundColor(.black)
                                Text("To win a trip to China, you need to write 25 stories about the country. Write about the people, culture, food and habits of China and its population. The promotion is valid until November 25, 2024")
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(.black.opacity(0.7))
                                    .multilineTextAlignment(.center)
                            }.padding(30).padding(.top, -10)
                        }.background(Color.black.opacity(0.05)).cornerRadius(16)
                        Spacer()
                        NavigationLink {
                            EventsUIView(viewModel: viewModel)
                                .navigationBarBackButtonHidden()
                        } label: {
                            ZStack {
                                Color.mainRed
                                HStack {
                                    Text("Go to event")
                                        .font(.system(size: 17, weight: .medium))
                                        .foregroundColor(.white)
                                }
                            }.frame(height: 52).cornerRadius(16)
                        }
                        
                        
                    }
                    Spacer()
                    
                }.padding(20)
                
                
            }
            
        }
    }
}

#Preview {
    EventUIView(eventShow: .constant(false), viewModel: NoteViewModel())
}
