//
//  SettingsViewModel.swift
//  app947
//
//  Created by Dias Atudinov on 02.10.2024.
//

import SwiftUI
import StoreKit

class SettingsViewModel: ObservableObject {
    
    func shareApp() {
        guard let url = URL(string: "https://itunes.apple.com/app/id6736528670") else { return }
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            rootViewController.present(activityVC, animated: true, completion: nil)
        }
    }
    
    func rateApp() {
        SKStoreReviewController.requestReview()
    }
    
    func openUsagePolicy() {
        guard let url = URL(string: "https://www.termsfeed.com/live/fb5b5628-e356-4e7a-b438-18a0a6a8371d") else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
