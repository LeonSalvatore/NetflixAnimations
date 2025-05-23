//
//  ContentView.swift
//  NetflixUIAnimations
//
//  Created by Leon Salvatore on 23.05.2025.
//

import SwiftUI

struct ContentView: View {
    
   @StateObject private var observer: MainObserver = .init()
  
    var body: some View {
        
        ZStack {
           
            MainView()
            
            HiddenView()
                        
            ProfileView(observing: observer)
            
            if !observer.doneLoading { SplashScreen() }
        }
        .environmentObject(observer)
        .preferredColorScheme(.dark)
    }
    
    @ViewBuilder
    private func HiddenView() -> some View {
        if observer.hideMainView {
            Rectangle()
                .fill(.black)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    ContentView()
}
