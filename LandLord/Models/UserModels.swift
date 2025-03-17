//
//  UserModels.swift
//  LandLord
//
//  Created for bunkeboyLandLord2
//  Medieval 8-bit themed real estate app
//

import Foundation
import SwiftUI

// MARK: - User Role Enum

/// Represents different user roles within the app
enum UserRole: String, Codable, CaseIterable {
    case agent = "Agent"         // Regular real estate agent
    case teamLeader = "Knight"   // Team leader (medieval: Knight)
    case admin = "Royalty"       // Admin user (medieval: Royalty)
    
    /// Returns the medieval icon for each role
    var icon: String {
        switch self {
        case .agent:
            return "shield.lefthalf.filled"
        case .teamLeader:
            return "shield.righthalf.filled"
        case .admin:
            return "crown"
        }
    }
    
    /// Returns the permissions level for each role
    var permissionLevel: Int {
        switch self {
        case .agent: return 1
        case .teamLeader: return 2
        case .admin: return 3
        }
    }
}

// MARK: - User Settings

/// User preferences and app settings
struct UserSettings: Codable, Equatable {
    /// Whether to show notifications
    var notificationsEnabled: Bool
    
    /// Theme preference (light, dark, system)
    var themePreference: ThemePreference
    
    /// Sound effects volume (0-100)
    var soundEffectsVolume: Int
    
    /// Background music volume (0-100)
    var backgroundMusicVolume: Int
    
    /// Whether to show tutorials
    var showTutorials: Bool
    
    /// Default initializer with reasonable defaults
    init(notificationsEnabled: Bool = true,
         themePreference: ThemePreference = .system,
         soundEffectsVolume: Int = 70,
         backgroundMusicVolume: Int = 50,
         showTutorials: Bool = true) {
        self.notificationsEnabled = notificationsEnabled
        self.themePreference = themePreference
        self.soundEffectsVolume = max(0, min(100, soundEffectsVolume))
        self.backgroundMusicVolume = max(0, min(100, backgroundMusicVolume))
        self.showTutorials = showTutorials
    }
}

/// Theme preference options
enum ThemePreference: String, Codable, CaseIterable {
    case light = "Light"
    case dark = "Dark"
    case system = "System"
}

// MARK: - User Stats

/// Tracks user performance metrics with medieval terminology
struct UserStats: Codable, Equatable {
    /// Properties sold (medieval: Kingdoms conquered)
    var propertiesSold: Int
    
    /// Properties listed (medieval: Lands claimed)
    var propertiesListed: Int
    
    /// Client meetings attended (medieval: Royal audiences)
    var clientMeetings: Int
    
    /// Success rate percentage (medieval: Victory rate)
    var successRate: Double
    
    /// Gold earned total
    var goldEarned: Int
    
    /// Current rank in the medieval hierarchy
    var rank: UserRank
    
    /// Shield points (lives)
    var shieldPoints: Int
    
    /// Heart points (health/energy)
    var heartPoints: Int
    
    /// Experience points
    var experiencePoints: Int
    
    /// Level (calculated based on experience points)
    var level: Int {
        // Simple level calculation: 1 level per 100 XP
        return (experiencePoints / 100) + 1
    }
    
    /// Default initializer with reasonable defaults
    init(propertiesSold: Int = 0,
         propertiesListed: Int = 0,
         clientMeetings: Int = 0,
         successRate: Double = 0.0,
         goldEarned: Int = 0,
         rank: UserRank = .squire,
         shieldPoints: Int = 3,
         heartPoints: Int = 5,
         experiencePoints: Int = 0) {
        self.propertiesSold = propertiesSold
        self.propertiesListed = propertiesListed
        self.clientMeetings = clientMeetings
        self.successRate = successRate
        self.goldEarned = goldEarned
        self.rank = rank
        self.shieldPoints = shieldPoints
        self.heartPoints = heartPoints
        self.experiencePoints = experiencePoints
    }
}

/// Medieval ranks for users to progress through
enum UserRank: String, Codable, CaseIterable {
    case squire = "Squire"           // Beginner
    case knight = "Knight"           // Intermediate
    case baron = "Baron"             // Advanced
    case duke = "Duke"               // Expert
    case royalty = "Royalty"         // Master
    
    /// Experience points required for each rank
    var requiredXP: Int {
        switch self {
        case .squire: return 0
        case .knight: return 300
        case .baron: return 1000
        case .duke: return 3000
        case .royalty: return 10000
        }
    }
    
    /// Icon for each rank
    var icon: String {
        switch self {
        case .squire: return "person.fill"
        case .knight: return "shield.fill"
        case .baron: return "flag.fill"
        case .duke: return "crown.fill"
        case .royalty: return "star.fill"
        }
    }
}

// MARK: - User Model

/// Main user model representing a LandLord app user
struct User: Identifiable, Codable, Equatable {
    /// Unique identifier
    var id: String
    
    /// User's display name
    var displayName: String
    
    /// User's email address
    var email: String
    
    /// User's role (agent, teamLeader, admin)
    var role: UserRole
    
    /// ID of the team the user belongs to (if any)
    var teamId: String?
    
    /// User's app settings
    var settings: UserSettings
    
    /// Whether user has completed onboarding
    var onboardingComplete: Bool
    
    /// User performance stats
    var stats: UserStats
    
    /// Date user was created
    var createdAt: Date
    
    /// Date user was last active
    var lastActive: Date
    
    /// User's avatar/profile image URL
    var avatarURL: URL?
    
    /// Default initializer with reasonable defaults
    init(id: String = UUID().uuidString,
         displayName: String,
         email: String,
         role: UserRole = .agent,
         teamId: String? = nil,
         settings: UserSettings = UserSettings(),
         onboardingComplete: Bool = false,
         stats: UserStats = UserStats(),
         createdAt: Date = Date(),
         lastActive: Date = Date(),
         avatarURL: URL? = nil) {
        self.id = id
        self.displayName = displayName
        self.email = email
        self.role = role
        self.teamId = teamId
        self.settings = settings
        self.onboardingComplete = onboardingComplete
        self.stats = stats
        self.createdAt = createdAt
        self.lastActive = lastActive
        self.avatarURL = avatarURL
    }
    
    /// Creates a new user with minimal required info
    static func newUser(displayName: String, email: String) -> User {
        return User(
            displayName: displayName,
            email: email,
            onboardingComplete: false
        )
    }
}

// MARK: - Extensions

extension User {
    /// Determine if user can access admin features
    var canAccessAdminFeatures: Bool {
        return role == .admin
    }
    
    /// Determine if user can manage team members
    var canManageTeam: Bool {
        return role == .teamLeader || role == .admin
    }
    
    /// Get the appropriate medieval title for the user
    var medievalTitle: String {
        if role == .admin {
            return "Your Majesty"
        } else if role == .teamLeader {
            return "Sir \(displayName)"
        } else {
            return stats.rank.rawValue + " " + displayName
        }
    }
    
    /// Get next rank user can achieve
    var nextRank: UserRank? {
        let currentIndex = UserRank.allCases.firstIndex(of: stats.rank) ?? 0
        let nextIndex = currentIndex + 1
        
        return nextIndex < UserRank.allCases.count ? UserRank.allCases[nextIndex] : nil
    }
    
    /// Get experience points needed for next rank
    var experiencePointsForNextRank: Int? {
        guard let next = nextRank else { return nil }
        return next.requiredXP - stats.experiencePoints
    }
}

// MARK: - User Profile Model

/// User profile model
struct UserProfile: Identifiable, Codable {
    let id: String
    var username: String
    var email: String
    var rank: String
    var gold: Int
    var xp: Int
    var joinDate: Date
    var lastActive: Date
    var profileImageUrl: String?
    
    var level: Int {
        return GameMechanicsModel.calculateLevel(xp: xp)
    }
}
