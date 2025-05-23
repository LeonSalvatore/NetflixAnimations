//
//  TabBarView.swift
//  NetflixUIAnimations
//
//  Created by Leon Salvatore on 23.05.2025.
//

import SwiftUI

struct TabBarView: View {
    @EnvironmentObject private var observing: MainObserver
    let tabs = Tabs.allCases
    
    var body: some View {
        HStack(spacing: .zero) {
            ForEach(tabs, content: TabButton)
        }
        .tabBarStyle()
        .vFrameAlignment(.bottom)
        
    }
    
    @ViewBuilder
    func TabButton(_ tab: Tabs) -> some View {
        Button {
            observing.currentTab = tab
        } label: {
            TabButtonLabel(tab: tab)
        }
        .buttonStyle(.netflixDefault)
        .simultaneousGesture(LongPressGesture().onEnded { _ in
            guard tab == .account && !observing.presentProfileView else { return }
            observing.resetProfileAnimation()
            withAnimation(.snappy(duration: 0.3)) {
                observing.navigateToProfile()
            }
        })
    }
}


public extension View {
    func hFrameAlignment(_ alignment: Alignment = .center) -> some View {
        frame(maxWidth: .infinity, alignment: alignment)
    }
    
    func vFrameAlignment(_ alignment: Alignment = .center) -> some View {
        frame(maxHeight: .infinity, alignment: alignment)
    }
    
    func tabBarStyle() -> some View {
        padding(.bottom, 10)
        .padding(.top, 5)
        .background {
            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
        }
        
    }
}
extension Equatable {
    func isEqual(to other: Self) -> Bool {
        self == other
    }
}

#Preview {
    TabBarView()
        .environmentObject(MainObserver())
        .preferredColorScheme(.dark)
}
