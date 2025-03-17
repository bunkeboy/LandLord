//
//  AuthViewModel.swift
//  LandLord
//
//  Created for bunkeboyLandLord2
//  Medieval 8-bit themed real estate app
//

import SwiftUI
import Combine
import Firebase
import FirebaseAuth

class AuthViewModel: ObservableObject {
    // Published properties
    @Published var currentUser: User?
    @Published var userProfile: UserProfile?
    @Published var isLoading = false
    @Published var error: String?
    
    // AppStorage for persisting authentication state
    @AppStorage("isAuthenticated") private var isAuthenticatedStorage = false
    @AppStorage("userId") private var userId: String = ""
    
    // Computed property for authentication state
    var isAuthenticated: Bool {
        get {
            return currentUser != nil
        }
        set {
            isAuthenticatedStorage = newValue
            // If setting to false, clear the current user
            if !newValue {
                currentUser = nil
            }
        }
    }
    
    // Initialize the view model
    init() {
        // Check if user is authenticated from storage
        if isAuthenticatedStorage {
            checkAuthState()
        }
    }
    
    /// Check if the user is still authenticated
    func checkAuthState() {
        if let currentUser = Auth.auth().currentUser {
            self.currentUser = currentUser
            self.isAuthenticatedStorage = true
            self.userId = currentUser.uid
        } else {
            self.isAuthenticatedStorage = false
            self.userId = ""
        }
    }
    
    /// Load user data from Firestore
    func loadUserData() {
        guard isAuthenticatedStorage, !userId.isEmpty else { return }
        
        isLoading = true
        
        // In a real app, this would fetch from Firestore
        // For now, we'll use sample data
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.userProfile = UserProfile(
                id: self.userId,
                username: "Sir Lancelot",
                email: "lancelot@camelot.com",
                rank: "Knight",
                gold: 250,
                xp: 1200,
                joinDate: Date().addingTimeInterval(-30 * 24 * 60 * 60), // 30 days ago
                lastActive: Date()
            )
            self.isLoading = false
        }
    }
    
    // Sign in method - creates a sample user for now
    func signIn(email: String, password: String, completion: @escaping (Bool) -> Void) {
        isLoading = true
        
        // In a real app, this would use Firebase Auth
        // For now, we'll simulate authentication
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.isAuthenticatedStorage = true
            self.userId = UUID().uuidString
            self.createSampleUser()
            self.isLoading = false
            completion(true)
        }
    }
    
    // Sign out method
    func signOut() {
        // In a real implementation, this would:
        // 1. Call Firebase Auth signOut
        do {
            // try Auth.auth().signOut()
            self.isAuthenticatedStorage = false
            self.userId = ""
            self.currentUser = nil
            self.userProfile = nil
        } catch {
            self.error = "Failed to sign out: \(error.localizedDescription)"
        }
    }
    
    // Helper method to create a sample user
    private func createSampleUser() {
        // Create sample user settings
        let settings = UserSettings(
            notificationsEnabled: true,
            themePreference: .system,
            soundEffectsVolume: 70,
            backgroundMusicVolume: 50,
            showTutorials: true
        )
        
        // Create sample user stats
        let stats = UserStats(
            propertiesSold: 5,
            propertiesListed: 12,
            clientMeetings: 20,
            successRate: 75.0,
            goldEarned: 1250,
            rank: .squire,
            shieldPoints: 3,
            heartPoints: 5,
            experiencePoints: 175
        )
        
        // Create the sample user
        currentUser = User(
            id: "user123",
            displayName: "Sir Lancelot",
            email: "lancelot@camelot.com",
            role: .agent,
            teamId: "team456",
            settings: settings,
            onboardingComplete: true,
            stats: stats,
            createdAt: Date().addingTimeInterval(-30 * 24 * 60 * 60), // 30 days ago
            lastActive: Date(),
            avatarURL: nil
        )
    }
    
    // MARK: - Additional Helper Methods (to be implemented later)
    
    // Update user profile
    func updateUserProfile(displayName: String, email: String) {
        // Update the current user's profile
        currentUser?.displayName = displayName
        currentUser?.email = email
        
        // In a real implementation, this would:
        // 1. Update Firebase Auth user profile
        // 2. Update Firestore user document
        
        print("User profile updated")
    }
    
    // Update user settings
    func updateUserSettings(_ settings: UserSettings) {
        // Update the current user's settings
        currentUser?.settings = settings
        
        // In a real implementation, this would:
        // 1. Update Firestore user document
        // 2. Update local storage
        
        print("User settings updated")
    }
    
    // Update user stats
    func updateUserStats(_ stats: UserStats) {
        // Update the current user's stats
        currentUser?.stats = stats
        
        // In a real implementation, this would:
        // 1. Update Firestore user document
        // 2. Update local storage
        
        print("User stats updated")
    }
} 