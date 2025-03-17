//
//  MainTabView.swift
//  LandLord
//
//  Created for bunkeboyLandLord2
//  Medieval 8-bit themed real estate app
//

import SwiftUI

struct MainTabView: View {
    // Selected tab
    @State private var selectedTab = 0
    
    // Medieval theme colors
    private let tabBarColor = Color("royalPurple") // Deep Purple
    private let tabSelectedColor = Color("medievalGold") // Gold
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Quests Tab
            QuestsView()
                .tabItem {
                    Label("Quests", systemImage: "scroll.fill")
                }
                .tag(0)
            
            // Treasury Tab
            TreasuryView()
                .tabItem {
                    Label("Treasury", systemImage: "dollarsign.circle.fill")
                }
                .tag(1)
            
            // Settings Tab
            SettingsView()
                .tabItem {
                    Label("Kingdom", systemImage: "gearshape.fill")
                }
                .tag(2)
        }
        .accentColor(tabSelectedColor) // Selected tab color
        .onAppear {
            // Style the tab bar with medieval theme
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(tabBarColor)
            
            // Style the selected and unselected items
            let itemAppearance = UITabBarItemAppearance()
            
            // Selected item
            itemAppearance.selected.iconColor = UIColor(tabSelectedColor)
            itemAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(tabSelectedColor)]
            
            // Normal item
            itemAppearance.normal.iconColor = UIColor.white
            itemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
            
            appearance.stackedLayoutAppearance = itemAppearance
            appearance.inlineLayoutAppearance = itemAppearance
            appearance.compactInlineLayoutAppearance = itemAppearance
            
            // Apply the appearance
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
            
            // Make tab bar always visible
            UITabBar.appearance().isTranslucent = false
        }
    }
}

#Preview {
    MainTabView()
}