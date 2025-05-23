//
//  AnimatedPositionModifier.swift
//  NetflixUIAnimations
//
//  Created by Leon Salvatore on 23.05.2025.
//

import SwiftUI

struct AnimatedPositionModifier: ViewModifier, Animatable {
    var source: CGPoint
    var center: CGPoint
    var destination: CGPoint
    var animateToCenter: Bool
    var animateToMainView: Bool
    var path: Path
    var progress: CGFloat
    
    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }
    
    func body(content: Content) -> some View {
        content
            .position(
                animateToCenter ? animateToMainView ? (path.trimmedPath(from: 0, to: progress).currentPoint ?? center) : center : source
            )
    }
}
