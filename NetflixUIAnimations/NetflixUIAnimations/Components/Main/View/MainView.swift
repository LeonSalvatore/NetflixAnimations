//
//  MainView.swift
//  NetflixUIAnimations
//
//  Created by Leon Salvatore on 23.05.2025.
//

import SwiftUI

struct MainView: View {
        
    var body: some View {
        VStack {
            
            NetflixMainPage()
            
           TabBarView()
        }
        .coordinateSpace(.named("MAINVIEW"))
    }
}

#Preview {
    ContentView()
}

struct NetflixMainPage: View {
    var body: some View {
        Text("Hello, World!")
    }
}
