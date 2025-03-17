import Foundation
import SwiftUI

// MARK: - Quest Model

/// Represents a quest that users can complete to earn rewards
struct Quest: Identifiable, Codable, Equatable {
    /// Unique identifier for the quest
    var id: UUID
    
    /// Title of the quest
    var title: String
    
    /// Detailed description of what needs to be done
    var description: String
    
    /// Amount of gold rewarded upon completion
    var goldReward: Int
    
    /// Amount of XP rewarded upon completion
    var xpReward: Int = 10
    
    /// Whether the quest has been completed
    var isCompleted: Bool = false
    
    /// Difficulty level of the quest
    var difficulty: QuestDifficulty = .normal
    
    /// Type of quest
    var type: QuestType = .property
    
    /// Deadline for completing the quest (if applicable)
    var deadline: Date?
    
    /// Date when the quest was created
    var createdAt: Date = Date()
    
    /// Date when the quest was completed (if applicable)
    var completedAt: Date?
    
    /// Additional metadata for the quest
    var metadata: [String: String]?
    
    // MARK: - Computed Properties
    
    /// Returns the icon name based on quest type
    var iconName: String {
        switch type {
        case .daily:
            return "sun.max.fill"
        case .weekly:
            return "calendar.badge.clock"
        case .special:
            return "star.fill"
        case .property:
            return "house.fill"
        }
    }
    
    /// Returns the color based on quest difficulty
    var difficultyColor: Color {
        switch difficulty {
        case .easy:
            return Color.green
        case .normal:
            return Color.blue
        case .hard:
            return Color.orange
        case .legendary:
            return Color.purple
        }
    }
    
    /// Returns a medieval-themed status description
    var statusText: String {
        isCompleted ? "Quest Fulfilled" : "Quest Awaits"
    }
    
    // MARK: - Methods
    
    /// Marks the quest as completed and sets the completion date
    mutating func complete() {
        isCompleted = true
        completedAt = Date()
    }
    
    /// Resets the quest to uncompleted status
    mutating func reset() {
        isCompleted = false
        completedAt = nil
    }
    
    /// Returns the total reward value (gold + XP)
    func totalRewardValue() -> Int {
        return goldReward + xpReward
    }
}

// MARK: - Supporting Enums

/// Difficulty levels for quests
enum QuestDifficulty: String, Codable, CaseIterable {
    case easy = "Easy"
    case normal = "Normal"
    case hard = "Hard"
    case legendary = "Legendary"
    
    /// Returns the point multiplier for each difficulty level
    var pointMultiplier: Double {
        switch self {
        case .easy: return 1.0
        case .normal: return 1.5
        case .hard: return 2.0
        case .legendary: return 3.0
        }
    }
    
    /// Returns the medieval-themed name for each difficulty
    var medievalName: String {
        switch self {
        case .easy: return "Squire's Task"
        case .normal: return "Knight's Duty"
        case .hard: return "Lord's Challenge"
        case .legendary: return "Royal Conquest"
        }
    }
}

/// Types of quests based on frequency and importance
enum QuestType: String, Codable, CaseIterable {
    case daily = "Daily"       // Daily quests
    case weekly = "Weekly"     // Weekly quests
    case special = "Special"   // Special one-time quests
    case property = "Property" // Property-related quests
    
    /// Returns the medieval-themed name for each quest type
    var medievalName: String {
        switch self {
        case .daily: return "Daily Decree"
        case .weekly: return "Weekly Mandate"
        case .special: return "Royal Command"
        case .property: return "Land Affairs"
        }
    }
}

// MARK: - Sample Data

extension Quest {
    /// Sample quests for preview and testing
    static var samples: [Quest] {
        [
            Quest(
                id: UUID(),
                title: "Post New Property",
                description: "List a new property in the marketplace",
                goldReward: 20,
                isCompleted: false,
                type: .daily
            ),
            Quest(
                id: UUID(),
                title: "Update Profile",
                description: "Keep thy profile information current",
                goldReward: 10,
                isCompleted: true,
                type: .daily
            ),
            Quest(
                id: UUID(),
                title: "Complete 5 Daily Quests",
                description: "Show thy dedication to the realm",
                goldReward: 50,
                xpReward: 25,
                type: .weekly
            ),
            Quest(
                id: UUID(),
                title: "Royal Appointment",
                description: "Sell a castle to nobility",
                goldReward: 200,
                xpReward: 100,
                difficulty: .legendary,
                type: .special
            )
        ]
    }
} 