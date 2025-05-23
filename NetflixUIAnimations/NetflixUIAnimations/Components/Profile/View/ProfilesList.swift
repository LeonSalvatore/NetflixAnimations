//
//  ProfilesList.swift
//  NetflixUIAnimations
//
//  Created by Leon Salvatore on 23.05.2025.
//

import SwiftUI


struct ProfilesList: View {
        
    let sample = Profile.sample
    let colums = Array(repeating: GridItem(.fixed(100), spacing: 25), count: 2)
    let animateToCenter: Bool
    let watchingProfile: Profile?
    
    let onAddProfile: (Profile)-> Void
    
    init(
        animateToCenter: Bool,
        watchingProfile: Profile?,
        onAddProfile: @escaping (Profile) -> Void) {
        self.animateToCenter = animateToCenter
        self.watchingProfile = watchingProfile
        self.onAddProfile = onAddProfile
    }
    
    var body: some View {
        LazyVGrid(columns: colums) {
            ForEach(sample, content: ProfileCard)
            
            AddProfileButton()
        }
        .vFrameAlignment()
    }
    // MARK:
    @ViewBuilder
    private func ProfileCard(_ profile: Profile) -> some View {
        VStack(spacing: 8) {
            let status = profile.id == watchingProfile?.id
            GeometryReader { _ in
                
                Image(profile.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(.rect(cornerRadius: 10))
                    .opacity(animateToCenter ? 0 : 1)
            }
            .animation(status ? .none : .bouncy(duration: 0.35), value: animateToCenter)
            .frame(width: 100, height: 100)
            .anchorPreference(key: RectAnchorKey.self, value: .bounds){ anchor in
                return [profile.soruceAnchorID: anchor]
            }
            .onTapGesture {
                onAddProfile(profile)
            }
            
            Text(profile.name)
                .fontWeight(.semibold)
                .lineLimit(1)
        }
    }
    
    //MARK:
    private func AddProfileButton() -> some View {
        
        Button {/* Add action here */}
        label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.white.opacity(0.8), lineWidth: 0.8)
                
                Image(systemName: "plus")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
            }
            .frame(width: 100, height: 100)
            .contentShape(.rect)
        }

    }
    
}


#Preview("Main View") {
    ContentView()
        .preferredColorScheme(.dark)
        .environmentObject(MainObserver())
}
