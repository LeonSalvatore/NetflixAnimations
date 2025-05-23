//
//  MainObserver.swift
//  NetflixUIAnimations
//
//  Created by Leon Salvatore on 23.05.2025.
//

import SwiftUI
import Observation

@MainActor
class MainObserver: ObservableObject {
    
    @Published var doneLoading: Bool = false
    @Published var hideMainView: Bool = false
    @Published var currentTab: Tabs = .home
    
   //MARK: Profile related properties
    @Published var presentProfileView: Bool = false
    @Published var tabProfileRect: CGRect = .zero
    @Published var watchingProfile: Profile?
    @Published var animateProfile: Bool = false
    @Published var fromTabBar: Bool = false
    
    //MARK: Profile Animation Properties
    @Published var animateToCenter: Bool = false
    @Published var animateToMainView: Bool = false
    @Published var progress: CGFloat = 0
    
    // lottie file bundle url
     var fileURL: URL? {
        if let bundlePath = Bundle.main.path(forResource: "Logo", ofType: "json") {
            return URL(filePath: bundlePath)
        }
        
        return nil
    }
    
}

// MARK: Methods
extension MainObserver {
    //MARK:
    func resetProfileAnimation() {
        animateToCenter = false
        animateToMainView = false
        progress = 0
    }
    // MARK:
    func cancelPresentProfiles() {
        withAnimation(.snappy(duration: 0.3, extraBounce: 0)) {
            presentProfileView = false
            hideMainView = false
            fromTabBar = false
        }
    }
    
    func stopProfileAnimation() {
        presentProfileView = false
        animateProfile = false
        fromTabBar = false

    }
    
    func navigateToProfile() {
        presentProfileView = true
        hideMainView = true
        fromTabBar = true
    }
    
    // MARK:
    func select(_ profile: Profile) {
        watchingProfile = profile
        animateProfile = true
        print("Selected Profile: \(profile.name)")
        print("Selected Profile is Being animated: \(animateProfile)")
    }
    
    //MARK:
    /// Load Contents
    func loadContents() async {
        /// Load Any Network Content Here
        try? await Task.sleep(for: .seconds(1))
    }
    //MARK:
    func animateUser() async {
        withAnimation(.bouncy(duration: 0.35)) {
            animateToCenter = true
        }
        
        await loadContents()
        
        withAnimation(.snappy(duration: 0.6, extraBounce: 0.1), completionCriteria: .removed) {
            self.animateToMainView = true
            self.hideMainView = false
            self.progress = 0.97
        } completion: {
            self.presentProfileView = false
            self.animateProfile = false
            self.fromTabBar = false
        }
    }
}
