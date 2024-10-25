//
//  UsOnboardingUIView.swift
//  app947
//
//  Created by Dias Atudinov on 25.09.2024.
//

import SwiftUI
import StoreKit

struct UsOnboardingUIView: View {
    @State private var progress: Double = 0.0
    @State private var timer: Timer?
    @State private var isLoadingView: Bool = true
    @State private var isNotificationView: Bool = true
    @State private var pageNum: Int = 1
    @AppStorage("onboardingShowed") var onboardingShowed: Bool = false
    
    var body: some View {
        if !onboardingShowed {
            if pageNum < 3 {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [.gradientTop, .gradientBottom]),
                                   startPoint: .top,
                                   endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                    
                    
                    VStack(spacing: 0) {
                        switch pageNum {
                        case 1:
                            VStack {
                                
                                Image("firstScreen947")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width)
                                    .padding(.top, 120)
                                    //.offset(y: 10)
                                // .frame(width: UIScreen.main.bounds.width - 48)
                                //.ignoresSafeArea(edges: .top)
                                // .padding(.bottom, -100)
                                
                            }
                        case 2: Image("ratings947")
                                .resizable()
                                .scaledToFill()
                                .frame(width: UIScreen.main.bounds.width)
                                .padding(.bottom, -32)
                            //.frame(width: UIScreen.main.bounds.width)
                        default:
                            Image("notifications874")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 500)
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
                                        Text("Start playing and earning")
                                            .font(.system(size: 28, weight: .bold))
                                            .multilineTextAlignment(.center)
                                        Text("A proven way to make easy money")
                                            .font(.system(size: 17, weight: .semibold))
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(.white.opacity(0.5))
                                        
                                    }.frame(height: 160).padding(.bottom, 10).foregroundColor(.white)
                                    
                                case 2:
                                    VStack(spacing: 12) {
                                        Text("Rate our app in the AppStore")
                                            .font(.system(size: 28, weight: .bold))
                                            .multilineTextAlignment(.center)
                                        Text("Help make the app even better")
                                            .font(.system(size: 17, weight: .semibold))
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(.white.opacity(0.5))
                                    }.frame(height: 160).padding(.bottom, 10).foregroundColor(.white)
                                        .onAppear{
                                            rateApp()
                                        }
                                default:
                                    Text("Don’t miss anything")
                                        .font(.title)
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                        .foregroundColor(.black)
                                        .padding(.bottom, 10)
                                    Text("Don’t miss the most userful information")
                                        .foregroundColor(.white).opacity(0.7)
                                    
                                }
                                //Spacer()
                                Button {
                                    if pageNum < 3 {
                                        pageNum += 1
                                    } else {
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
                                    
                                }
                                .padding()
                                
                            }
                            
                            
                            
                        }.edgesIgnoringSafeArea(.bottom)
                            .offset(y: pageNum == 1 ? -173 : 0)
                    }
                    
                    
                }
            } else {
                if isNotificationView {
                    ZStack {
                        LinearGradient(gradient: Gradient(colors: [.gradientTop, .gradientBottom]),
                                       startPoint: .top,
                                       endPoint: .bottom)
                        .edgesIgnoringSafeArea(.all)
                        
                        ZStack {
                            
                            
                            VStack(spacing: 0) {
                                HStack {
                                    Spacer()
                                    Button {
                                        isNotificationView = false
                                    } label : {
                                        ZStack {
                                            Circle()
                                                .frame(width: 30 ,height: 30)
                                                .foregroundColor(.black.opacity(0.2))
                                            Image(systemName: "xmark")
                                                .font(.system(size: 12, weight: .bold))
                                                .foregroundColor(.white)
                                        }
                                    }
                                }.padding(.horizontal)
                                Image("notifications947")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width - 40)
                                    .padding(.top, 35)
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(.mainRed)
                                        .cornerRadius(30)
                                    VStack {
                                        VStack(spacing: 12) {
                                            Text("Don’t miss anything")
                                                .font(.system(size: 28, weight: .bold))
                                                .multilineTextAlignment(.center)
                                            Text("Don’t miss the most userful information")
                                                .font(.system(size: 17, weight: .semibold))
                                                .multilineTextAlignment(.center)
                                                .foregroundColor(.white.opacity(0.5))
                                        }.frame(height: 100).padding(.bottom, 50).padding(.horizontal, 30).foregroundColor(.white)
                                        
                                        
                                        Button {
                                            isNotificationView = false
                                            onboardingShowed = true
                                        } label: {
                                            Text("Next")
                                                .foregroundColor(Color.mainRed)
                                                .font(.system(size: 20, weight: .semibold))
                                                .padding()
                                                .frame(maxWidth: .infinity)
                                        }.frame(height: 60).background(Color.white)
                                            .cornerRadius(35).padding(.horizontal)
                                            .padding(.bottom)
                                    }
                                }.edgesIgnoringSafeArea(.bottom)
                            }
                            
                        }
                    }
                    
                } else {
                    //WebUIView()
                }
            }
        } else {
            // WebUIView()
        }
    }
    
    func startTimer() {
        timer?.invalidate()
        progress = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.07, repeats: true) { timer in
            if progress < 100 {
                progress += 1
            } else {
                timer.invalidate()
                isLoadingView.toggle()
            }
        }
    }
    
    func rateApp() {
        SKStoreReviewController.requestReview()
    }
}


#Preview {
    UsOnboardingUIView()
}
