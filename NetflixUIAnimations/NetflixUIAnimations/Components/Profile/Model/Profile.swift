//
//  Profile.swift
//  NetflixUIAnimations
//
//  Created by Leon Salvatore on 23.05.2025.
//

import SwiftUI

struct Profile: Identifiable {
    var id: UUID = .init()
    var name: String
    var icon: String
    
    var soruceAnchorID: String {
        return id.uuidString + "SOURCE"
    }
    
    var destinationAnchorID: String {
        return id.uuidString + "DESTINATION"
    }
    
    static var sample: [Profile] = [
        .init(name: "Leon", icon: "leon"),
        .init(name: "Guest", icon: "nick"),
        .init(name: "John", icon: "Logo")
    ]
}


