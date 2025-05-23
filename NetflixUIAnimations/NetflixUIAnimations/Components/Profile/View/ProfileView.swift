//
//  ProfileView.swift
//  NetflixUIAnimations
//
//  Created by Leon Salvatore on 23.05.2025.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var observing: MainObserver
    
    var body: some View {
        
        ZStack {
            if observing.presentProfileView {
                
                VStack {
                    
                    Header()
                   
                    ProfilesList(
                        animateToCenter: observing.animateToCenter,
                        watchingProfile: observing.watchingProfile) { profile in
                            observing.select(profile)
                        }
                }
                .padding(15)
                .hFrameAlignment()
                .vFrameAlignment()
                .opacity(observing.animateToCenter ? 0 : 1)
                .background(.black)
                .opacity(observing.animateToMainView ? 0 : 1)
                .overlayPreferenceValue(RectAnchorKey.self) { value in
                    AnimationLayerView(value)
                }
            }
        }
        .animation(.snappy, value: observing.presentProfileView)
        .task {
            // tutorial purpose
            observing.watchingProfile = .sample.first
        }
        
    }
    
    // MARK:
    private func Header() -> some View {
        Button("profile.edit"){ /*edit action */}
            .hFrameAlignment(.trailing)
            .overlay {
                Text("profile.message")
                    .font(.title3.bold())
            }
            .overlay(alignment: .leading) {
                 if observing.fromTabBar {
                    // Button to dismiss Profile View
                    XButton()
                }
            }
    }
    
    private func XButton() -> some View {
        Button("",
            systemImage: "xmark",
            action: observing.cancelPresentProfiles)
        .font(.title3)
        .foregroundStyle(.white)
        .contentShape(.rect)
        .buttonStyle(.netflixDefault)
    }
}

#Preview {
    ProfileView(observing: .init())
        .environmentObject(MainObserver())
        .preferredColorScheme(.dark)
}
