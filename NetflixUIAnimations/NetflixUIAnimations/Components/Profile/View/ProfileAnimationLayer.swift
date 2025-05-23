//
//  ProfileAnimationLayer.swift
//  NetflixUIAnimations
//
//  Created by Leon Salvatore on 23.05.2025.
//

import SwiftUI

struct AnimationLayerView: View {
    
    @EnvironmentObject private var observing: MainObserver
    
    var value: [String: Anchor<CGRect>]
    
    init(_ value: [String: Anchor<CGRect>]) {
        self.value = value
     
    }
    var body: some View {
       
        GeometryReader { proxy in
            
            if let profile = observing.watchingProfile, let sourceAnchor = value[profile.soruceAnchorID], observing.animateProfile, observing.tabProfileRect != .zero {
                let sRect = proxy[sourceAnchor]
                let screenRect = proxy.frame(in: .global)
                /// Positions
                let sourcePosition = CGPoint(x: sRect.midX, y: sRect.midY)
                let centerPosition = CGPoint(x: screenRect.width / 2, y: (screenRect.height / 2) - 40)
                let destinationPosition = CGPoint(x: observing.tabProfileRect.midX, y: observing.tabProfileRect.midY)
                
                let animationPath = Path { path in
                    path.move(to: centerPosition)
                    path.addQuadCurve(to: destinationPosition, control: CGPoint(x: centerPosition.x * 2, y: centerPosition.y - (centerPosition.y / 0.8)))
                }
                
                /// To visuvalize Animation Path
                //animationPath.stroke(.white.opacity(0.5), lineWidth: 1)
                
                let endPosition = animationPath.trimmedPath(from: 0, to: 1).currentPoint ?? destinationPosition
                let currentPosition = animationPath.trimmedPath(from: 0, to: 0.97).currentPoint ?? destinationPosition
                
                let diff = CGSize(width: endPosition.x - currentPosition.x, height: endPosition.y - currentPosition.y)
                
                /// Selected Profile Image View With Loading Indicator
                ZStack {
                    Image(profile.icon)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: observing.animateToMainView ? 25 : sRect.width, height: observing.animateToMainView ? 25 : sRect.height)
                        .clipShape(.rect(cornerRadius: observing.animateToMainView ? 4 : 10))
                        .animation(.snappy(duration: 0.3, extraBounce: 0), value: observing.animateToMainView)
                        .opacity(observing.animateToMainView && observing.currentTab != .account ? 0.6 : 1)
                        .modifier(
                            AnimatedPositionModifier(
                                source: sourcePosition,
                                center: centerPosition,
                                destination: destinationPosition,
                                animateToCenter: observing.animateToCenter,
                                animateToMainView: observing.animateToMainView,
                                path: animationPath,
                                progress: observing.progress
                            )
                        )
                        .offset(observing.animateToMainView ? diff : .zero)
                    
//                    NetflixLoader()
                    ProgressView()
                        .frame(width: 60, height: 60)
                        .offset(y: 80)
                        .opacity(observing.animateToCenter ? 1 : 0)
                        .opacity(observing.animateToMainView ? 0 : 1)
                }
                .transition(.identity)
                .task {
                    guard !observing.animateToCenter else { return }
                    await observing.animateUser()
                }
            }
        }
    }
    
}
