//
//  NetflixDefaultButtonStyle.swift
//  NetflixUIAnimations
//
//  Created by Leon Salvatore on 23.05.2025.
//


import SwiftUI

struct NetflixDefaultButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}
extension ButtonStyle where Self == NetflixDefaultButtonStyle {
    static var netflixDefault: Self {NetflixDefaultButtonStyle()}
}
