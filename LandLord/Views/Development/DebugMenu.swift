//
//  DebugMenu.swift
//  LandLord
//
//  Created for bunkeboyLandLord2
//  Medieval 8-bit themed real estate app
//

import SwiftUI

/// A debug menu that provides developer tools for testing
/// Only appears in DEBUG build configuration
struct DebugMenu: View {
    // Whether the debug panel is expanded
    @State private var isExpanded = false
    
    // AppStorage values to modify
    @AppStorage("isAuthenticated") private var isAuthenticated = false
    @AppStorage("onboardingComplete") private var onboardingComplete = false
    
    // Access to view models (would be injected in a real app)
    @EnvironmentObject private var authViewModel: AuthViewModel
    
    // Debug panel position
    private let buttonSize: CGFloat = 44
    private let expandedWidth: CGFloat = 250
    private let expandedHeight: CGFloat = 350
    
    var body: some View {
        #if DEBUG
        ZStack {
            // Collapsed button
            if !isExpanded {
                Button(action: {
                    withAnimation(.spring()) {
                        isExpanded = true
                    }
                }) {
                    Image(systemName: "ladybug.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                        .frame(width: buttonSize, height: buttonSize)
                        .background(Circle().fill(Color.red))
                        .shadow(radius: 3)
                }
                .position(x: UIScreen.main.bounds.width - 40, y: UIScreen.main.bounds.height - 100)
            }
            
            // Expanded panel
            if isExpanded {
                VStack(spacing: 0) {
                    // Header
                    HStack {
                        Text("Debug Menu")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation(.spring()) {
                                isExpanded = false
                            }
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                    .background(Color.red)
                    
                    // Debug actions
                    ScrollView {
                        VStack(spacing: 16) {
                            // Authentication section
                            DebugSection(title: "Authentication") {
                                DebugButton(
                                    title: "Reset Onboarding",
                                    icon: "arrow.counterclockwise",
                                    action: resetOnboarding
                                )
                                
                                DebugButton(
                                    title: "Toggle Auth State",
                                    icon: "person.fill.questionmark",
                                    action: toggleAuthState
                                )
                                
                                DebugButton(
                                    title: "Reset User Data",
                                    icon: "trash.fill",
                                    action: resetUserData
                                )
                            }
                            
                            // Game mechanics section
                            DebugSection(title: "Game Mechanics") {
                                DebugButton(
                                    title: "Add 100 Gold",
                                    icon: "coins.fill",
                                    action: addGold
                                )
                                
                                DebugButton(
                                    title: "Complete All Quests",
                                    icon: "checkmark.seal.fill",
                                    action: completeAllQuests
                                )
                                
                                DebugButton(
                                    title: "Add Achievement",
                                    icon: "trophy.fill",
                                    action: addRandomAchievement
                                )
                                
                                DebugButton(
                                    title: "Level Up",
                                    icon: "arrow.up.circle.fill",
                                    action: levelUp
                                )
                            }
                            
                            // App state section
                            DebugSection(title: "App State") {
                                DebugToggle(
                                    title: "Vacation Mode",
                                    icon: "tent.fill",
                                    isOn: .constant(false)
                                )
                                
                                DebugButton(
                                    title: "Simulate Crash",
                                    icon: "exclamationmark.triangle.fill",
                                    action: simulateCrash
                                )
                                
                                DebugButton(
                                    title: "Reset App State",
                                    icon: "arrow.triangle.2.circlepath",
                                    action: resetAppState
                                )
                            }
                            
                            // Current state info
                            DebugInfoView()
                        }
                        .padding()
                    }
                }
                .frame(width: expandedWidth, height: expandedHeight)
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 5)
                .position(x: UIScreen.main.bounds.width - expandedWidth/2 - 20, 
                          y: UIScreen.main.bounds.height - expandedHeight/2 - 40)
            }
        }
        .zIndex(1000) // Ensure it's above all other content
        #endif
    }
    
    // MARK: - Debug Actions
    
    /// Reset onboarding state
    private func resetOnboarding() {
        onboardingComplete = false
        print("Debug: Onboarding state reset")
    }
    
    /// Toggle authentication state
    private func toggleAuthState() {
        isAuthenticated.toggle()
        print("Debug: Authentication state toggled to \(isAuthenticated)")
    }
    
    /// Reset user data
    private func resetUserData() {
        // In a real app, this would clear user data from UserDefaults and/or database
        isAuthenticated = false
        onboardingComplete = false
        
        // Reset user in AuthViewModel
        // authViewModel.currentUser = nil
        
        print("Debug: User data reset")
    }
    
    /// Add gold for testing
    private func addGold() {
        // In a real app, this would update the user's gold in the database
        // For now, just print a message
        print("Debug: Added 100 gold")
    }
    
    /// Complete all quests
    private func completeAllQuests() {
        // In a real app, this would mark all quests as completed
        // For now, just print a message
        print("Debug: Completed all quests")
    }
    
    /// Add a random achievement
    private func addRandomAchievement() {
        // In a real app, this would add a random achievement
        // For now, just print a message
        let randomType = AchievementType.allCases.randomElement() ?? .firstQuest
        print("Debug: Added achievement: \(randomType.displayName)")
    }
    
    /// Level up the user
    private func levelUp() {
        // In a real app, this would increase the user's level
        // For now, just print a message
        print("Debug: User leveled up")
    }
    
    /// Simulate a crash
    private func simulateCrash() {
        print("Debug: Simulating crash")
        // This would normally cause a crash, but we'll just print a message
        // fatalError("Simulated crash")
    }
    
    /// Reset all app state
    private func resetAppState() {
        // In a real app, this would reset all app state
        isAuthenticated = false
        onboardingComplete = false
        
        // Clear UserDefaults
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
        
        print("Debug: App state reset")
    }
}

// MARK: - Helper Views

/// A section in the debug menu
struct DebugSection<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .foregroundColor(.gray)
            
            content
                .padding(.leading, 8)
        }
        .padding(.vertical, 8)
    }
}

/// A debug button
struct DebugButton: View {
    let title: String
    let icon: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .frame(width: 24, height: 24)
                
                Text(title)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(Color.blue)
            .cornerRadius(8)
        }
    }
}

/// A debug toggle
struct DebugToggle: View {
    let title: String
    let icon: String
    @Binding var isOn: Bool
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundColor(.primary)
                .frame(width: 24, height: 24)
            
            Text(title)
                .font(.system(size: 14, weight: .medium))
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .labelsHidden()
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(8)
    }
}

/// A view showing current app state information
struct DebugInfoView: View {
    @AppStorage("isAuthenticated") private var isAuthenticated = false
    @AppStorage("onboardingComplete") private var onboardingComplete = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Current State")
                .font(.headline)
                .foregroundColor(.gray)
            
            HStack {
                Text("Authenticated:")
                    .font(.system(size: 12))
                
                Spacer()
                
                Text(isAuthenticated ? "Yes" : "No")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(isAuthenticated ? .green : .red)
            }
            
            HStack {
                Text("Onboarding Complete:")
                    .font(.system(size: 12))
                
                Spacer()
                
                Text(onboardingComplete ? "Yes" : "No")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(onboardingComplete ? .green : .red)
            }
            
            HStack {
                Text("Build:")
                    .font(.system(size: 12))
                
                Spacer()
                
                Text("DEBUG")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.orange)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
    }
}

#if DEBUG
struct DebugMenu_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.gray.opacity(0.3).ignoresSafeArea()
            
            VStack {
                Text("App Content")
                    .font(.largeTitle)
            }
            
            DebugMenu()
        }
    }
}
#endif 