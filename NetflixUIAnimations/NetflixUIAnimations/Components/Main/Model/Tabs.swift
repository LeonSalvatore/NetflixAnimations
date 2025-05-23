//
//  Tabs.swift
//  NetflixUIAnimations
//
//  Created by Leon Salvatore on 23.05.2025.
//

import SwiftUI

enum Tabs: String, Identifiable, CaseIterable {
    var id: String { self.rawValue }
    case home = "Home"
    case new = "New & Hot"
    case account = "My Netflix"
    
    var icon: String {
        switch self {
        case .home:
            return "house.fill"
        case .new:
            return "play.rectangle.on.rectangle"
        case .account:
            return "Profile"
        }
    }
    
    var title: LocalizedStringKey {
        return LocalizedStringKey(self.rawValue)
    }
}
