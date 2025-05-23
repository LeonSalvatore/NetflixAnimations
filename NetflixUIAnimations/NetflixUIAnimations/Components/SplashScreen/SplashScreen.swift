//
//  SplashScreen.swift
//  NetflixUIAnimations
//
//  Created by Leon Salvatore on 23.05.2025.
//

import SwiftUI
import Lottie

struct SplashScreen: View {
    
    @EnvironmentObject private var observing: MainObserver
    
    @State private var progress: CGFloat = 0.0
    
    let frame: CGSize = .init(width: 600, height: 400)
    
    var body: some View {
        // DARK BG
        Rectangle()
            .fill(.black)
            // Lottie View
            .overlay {
                if let url = observing.fileURL {
                    LottieView {
                        await LottieAnimation.loadedFrom(url: url)
                    }
                    .playing(.fromProgress(0, toProgress: progress, loopMode: .playOnce))
                    .animationDidFinish { finished in
                        observing.doneLoading = progress != 0 && finished
                    }
                    .frame(width: frame.width, height: frame.height)
                    .task {
                        try? await Task.sleep(for: .seconds(0.15))
                        progress = 0.8
                    }
                }
            }
            .ignoresSafeArea()
    }
}

#Preview {
    SplashScreen()
        .environmentObject(MainObserver())
}
