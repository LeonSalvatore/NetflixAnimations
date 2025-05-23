//
//  TabButtonLabel.swift
//  NetflixUIAnimations
//
//  Created by Leon Salvatore on 23.05.2025.
//

import SwiftUI

struct TabButtonLabel: View {
    
    @EnvironmentObject private var observing: MainObserver
    
    let tab: Tabs
    
    var isActive: Bool {observing.currentTab == tab}
    
    var body: some View {
        VStack(spacing: 2) {
            Group {
                if tab.icon.isEqual(to: "Profile") {
                    GeometryReader { proxy in
                        let rect = proxy.frame(in: .named("MAINVIEW"))
                        
                        if let profile = observing.watchingProfile, !observing.animateProfile {
                            
                            Image(profile.icon)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 25, height: 25)
                                .clipShape(.rect(cornerRadius: 4))
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        
                        Color.clear
                            .preference(key: RectKey.self, value: rect)
                            .onPreferenceChange(RectKey.self) {
                                observing.tabProfileRect = $0
                            }
                    }
                    .frame(width: 35, height: 35)
                    
                } else {
                    Image(systemName: tab.icon)
                        .font(.title3)
                        .frame(width: 35, height: 35)
                }
                    
            }
            .keyframeAnimator(initialValue: 1, trigger: observing.currentTab) { content, scale in
                                content
                    .scaleEffect(isActive ? scale : 1)
            } keyframes: { _ in
                CubicKeyframe(1.2, duration: 0.2)
                CubicKeyframe(1, duration: 0.2)
            }
            
            Text(tab.title)
                .font(.caption2)
        }
        .hFrameAlignment(.bottom)
        .foregroundStyle(.white)
        .animation(.snappy) { content in
            content
                .opacity(isActive ? 1 : 0.6)
        }
        .contentShape(.rect)
        
    }
}

#Preview("Content View") {
    ContentView()
        .environmentObject(MainObserver())
    .preferredColorScheme(.dark)
}

#Preview("Tab Button Label") {
    TabButtonLabel(tab: .new)
        .environmentObject(MainObserver())
        .preferredColorScheme(.dark)
}
