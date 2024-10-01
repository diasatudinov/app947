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
        guard let url = URL(string: "https://apps.apple.com/app/golfstat-win-guru/id6670453682") else { return }
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
        guard let url = URL(string: "https://www.termsfeed.com/live/61db5db7-6501-43e9-8422-5c4aa3e6ddd0") else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
