//
//  GoalModels.swift
//  LandLord
//
//  Created for bunkeboyLandLord2
//  Medieval 8-bit themed real estate app
//

import Foundation

// MARK: - Quest Type Enum

/// Represents different types of real estate activities as quests
enum ActivityType: String, Codable, CaseIterable {
    case listing = "Claim Land"          // Create a new listing
    case showing = "Royal Tour"          // Show a property
    case offer = "Treaty Proposal"       // Submit an offer
    case closing = "Kingdom Acquisition" // Close a deal
    case prospecting = "Scout Mission"   // Find new clients
    case training = "Knight Training"    // Complete training
    case marketing = "Town Crier"        // Marketing activities
    
    /// Returns the medieval icon for each quest type
    var icon: String {
        switch self {
        case .listing:
            return "flag.fill"
        case .showing:
            return "building.columns.fill"
        case .offer:
            return "doc.text.fill"
        case .closing:
            return "checkmark.seal.fill"
        case .prospecting:
            return "binoculars.fill"
        case .training:
            return "book.fill"
        case .marketing:
            return "megaphone.fill"
        }
    }
    
    /// Returns the difficulty level for each quest type
    var difficultyLevel: Int {
        switch self {
        case .listing: return 3
        case .showing: return 1
        case .offer: return 2
        case .closing: return 4
        case .prospecting: return 2
        case .training: return 1
        case .marketing: return 2
        }
    }
}

// MARK: - Quest Status Enum

/// Represents the status of a quest
enum QuestStatus: String, Codable, CaseIterable {
    case notStarted = "Quest Awaits"  // Not started
    case inProgress = "On Quest"      // In progress
    case completed = "Victory"        // Completed
    
    /// Returns the medieval icon for each status
    var icon: String {
        switch self {
        case .notStarted:
            return "hourglass"
        case .inProgress:
            return "figure.walk"
        case .completed:
            return "flag.checkered"
        }
    }
}

// MARK: - Quest Model

/// Represents a daily task or quest in the medieval-themed real estate app
struct Quest: Identifiable, Codable, Equatable {
    /// Unique identifier
    var id: String
    
    /// ID of the user this quest belongs to
    var userId: String
    
    /// Title of the quest
    var title: String
    
    /// Detailed description of the quest
    var description: String
    
    /// Type of real estate activity
    var type: ActivityType
    
    /// Current status of the quest
    var status: QuestStatus
    
    /// Due date for the quest
    var date: Date
    
    /// Gold reward for completing the quest
    var goldReward: Int
    
    /// Experience points reward
    var experienceReward: Int
    
    /// Whether this is a special quest (gives bonus rewards)
    var isSpecialQuest: Bool
    
    /// Default initializer with reasonable defaults
    init(id: String = UUID().uuidString,
         userId: String,
         title: String,
         description: String,
         type: ActivityType,
         status: QuestStatus = .notStarted,
         date: Date = Date(),
         goldReward: Int = 50,
         experienceReward: Int = 25,
         isSpecialQuest: Bool = false) {
        self.id = id
        self.userId = userId
        self.title = title
        self.description = description
        self.type = type
        self.status = status
        self.date = date
        self.goldReward = goldReward
        self.experienceReward = experienceReward
        self.isSpecialQuest = isSpecialQuest
    }
}

// MARK: - Annual Goal

/// Represents a user's annual goals for real estate performance
struct AnnualGoal: Identifiable, Codable {
    /// Unique identifier for the goal
    var id: String = UUID().uuidString
    
    /// ID of the user who set the goal
    var userId: String
    
    /// Target for Gross Commission Income (GCI)
    var gciTarget: Double
    
    /// Target for sales volume
    var volumeTarget: Double
    
    /// Target for number of transactions
    var transactionTarget: Int
    
    /// Year for which the goal is set
    var year: Int
    
    /// Date when the goal was created
    var createdDate: Date = Date()
    
    /// Date when the goal was last updated
    var updatedDate: Date = Date()
    
    // MARK: - Computed Properties
    
    /// Average transaction value based on volume target and transaction target
    var averageTransactionValue: Double {
        guard transactionTarget > 0 else { return 0 }
        return volumeTarget / Double(transactionTarget)
    }
    
    /// Average commission per transaction based on GCI target and transaction target
    var averageCommission: Double {
        guard transactionTarget > 0 else { return 0 }
        return gciTarget / Double(transactionTarget)
    }
    
    /// Effective commission rate based on GCI target and volume target
    var effectiveCommissionRate: Double {
        guard volumeTarget > 0 else { return 0 }
        return (gciTarget / volumeTarget) * 100
    }
    
    /// Monthly GCI target
    var monthlyGciTarget: Double {
        return gciTarget / 12
    }
    
    /// Monthly volume target
    var monthlyVolumeTarget: Double {
        return volumeTarget / 12
    }
    
    /// Monthly transaction target
    var monthlyTransactionTarget: Double {
        return Double(transactionTarget) / 12
    }
}

// MARK: - Monthly Goal

/// Represents a user's monthly goals for real estate performance
struct MonthlyGoal: Identifiable, Codable {
    /// Unique identifier for the goal
    var id: String = UUID().uuidString
    
    /// ID of the user who set the goal
    var userId: String
    
    /// Target for Gross Commission Income (GCI)
    var gciTarget: Double
    
    /// Target for sales volume
    var volumeTarget: Double
    
    /// Target for number of transactions
    var transactionTarget: Int
    
    /// Year for which the goal is set
    var year: Int
    
    /// Month for which the goal is set (1-12)
    var month: Int
    
    /// Date when the goal was created
    var createdDate: Date = Date()
    
    /// Date when the goal was last updated
    var updatedDate: Date = Date()
    
    // MARK: - Computed Properties
    
    /// Average transaction value based on volume target and transaction target
    var averageTransactionValue: Double {
        guard transactionTarget > 0 else { return 0 }
        return volumeTarget / Double(transactionTarget)
    }
    
    /// Average commission per transaction based on GCI target and transaction target
    var averageCommission: Double {
        guard transactionTarget > 0 else { return 0 }
        return gciTarget / Double(transactionTarget)
    }
    
    /// Effective commission rate based on GCI target and volume target
    var effectiveCommissionRate: Double {
        guard volumeTarget > 0 else { return 0 }
        return (gciTarget / volumeTarget) * 100
    }
    
    /// Month name
    var monthName: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        if let date = calendar.date(from: dateComponents) {
            return dateFormatter.string(from: date)
        }
        return "Unknown"
    }
}

// MARK: - Goal Progress

/// Tracks progress towards a goal
struct GoalProgress: Identifiable, Codable {
    /// Unique identifier for the progress
    var id: String = UUID().uuidString
    
    /// ID of the user
    var userId: String
    
    /// Type of goal (annual or monthly)
    var goalType: GoalType
    
    /// Year for which the progress is tracked
    var year: Int
    
    /// Month for which the progress is tracked (if applicable)
    var month: Int?
    
    /// Current GCI achieved
    var currentGci: Double = 0
    
    /// Current volume achieved
    var currentVolume: Double = 0
    
    /// Current transactions completed
    var currentTransactions: Int = 0
    
    /// Date when the progress was last updated
    var updatedDate: Date = Date()
    
    // MARK: - Computed Properties
    
    /// GCI progress percentage
    func gciProgressPercentage(target: Double) -> Double {
        guard target > 0 else { return 0 }
        return min((currentGci / target) * 100, 100)
    }
    
    /// Volume progress percentage
    func volumeProgressPercentage(target: Double) -> Double {
        guard target > 0 else { return 0 }
        return min((currentVolume / target) * 100, 100)
    }
    
    /// Transaction progress percentage
    func transactionProgressPercentage(target: Int) -> Double {
        guard target > 0 else { return 0 }
        return min((Double(currentTransactions) / Double(target)) * 100, 100)
    }
    
    /// Overall progress percentage (average of all metrics)
    func overallProgressPercentage(gciTarget: Double, volumeTarget: Double, transactionTarget: Int) -> Double {
        let gciProgress = gciProgressPercentage(target: gciTarget)
        let volumeProgress = volumeProgressPercentage(target: volumeTarget)
        let transactionProgress = transactionProgressPercentage(target: transactionTarget)
        
        return (gciProgress + volumeProgress + transactionProgress) / 3
    }
}

// MARK: - Goal Type Enum

/// Types of goals
enum GoalType: String, Codable {
    case annual = "Annual"
    case monthly = "Monthly"
    
    var description: String {
        switch self {
        case .annual:
            return "Yearly Goal"
        case .monthly:
            return "Monthly Goal"
        }
    }
}

// MARK: - Sample Data

extension AnnualGoal {
    /// Sample annual goals for preview and testing
    static var samples: [AnnualGoal] {
        [
            AnnualGoal(
                userId: "user123",
                gciTarget: 100000,
                volumeTarget: 1000000,
                transactionTarget: 10,
                year: 2023
            ),
            AnnualGoal(
                userId: "user123",
                gciTarget: 150000,
                volumeTarget: 1500000,
                transactionTarget: 15,
                year: 2024
            )
        ]
    }
}

extension MonthlyGoal {
    /// Sample monthly goals for preview and testing
    static var samples: [MonthlyGoal] {
        [
            MonthlyGoal(
                userId: "user123",
                gciTarget: 8333,
                volumeTarget: 83333,
                transactionTarget: 1,
                year: 2023,
                month: 1
            ),
            MonthlyGoal(
                userId: "user123",
                gciTarget: 8333,
                volumeTarget: 83333,
                transactionTarget: 1,
                year: 2023,
                month: 2
            ),
            MonthlyGoal(
                userId: "user123",
                gciTarget: 12500,
                volumeTarget: 125000,
                transactionTarget: 1,
                year: 2024,
                month: 1
            )
        ]
    }
}

// MARK: - Extensions

extension AnnualGoal {
    /// Calculate percentage completion of GCI target
    var gciCompletion: Double {
        guard gciTarget > 0 else { return 0 }
        return min(1.0, currentGci / gciTarget) * 100
    }
    
    /// Calculate percentage completion of volume target
    var volumeCompletion: Double {
        guard volumeTarget > 0 else { return 0 }
        return min(1.0, currentVolume / volumeTarget) * 100
    }
    
    /// Calculate percentage completion of transaction target
    var transactionCompletion: Double {
        guard transactionTarget > 0 else { return 0 }
        return min(1.0, Double(currentTransactions) / Double(transactionTarget)) * 100
    }
    
    /// Calculate overall completion percentage (average of all targets)
    var overallCompletion: Double {
        return (gciCompletion + volumeCompletion + transactionCompletion) / 3.0
    }
    
    /// Get medieval-themed description of progress
    var medievalProgressDescription: String {
        let completion = overallCompletion
        
        if completion < 10 {
            return "Your quest has just begun, brave knight!"
        } else if completion < 25 {
            return "The kingdom grows slowly but surely."
        } else if completion < 50 {
            return "Halfway to conquering the realm!"
        } else if completion < 75 {
            return "Victory is within sight!"
        } else if completion < 100 {
            return "The crown is nearly yours!"
        } else {
            return "All hail the conquering hero!"
        }
    }
}

extension Quest {
    /// Calculate days remaining until quest due date
    var daysRemaining: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: Date(), to: date)
        return components.day ?? 0
    }
    
    /// Get medieval-themed urgency description
    var urgencyDescription: String {
        let days = daysRemaining
        
        if days < 0 {
            return "The kingdom has fallen!"
        } else if days == 0 {
            return "The battle is upon us!"
        } else if days <= 1 {
            return "Prepare for battle!"
        } else if days <= 3 {
            return "The enemy approaches!"
        } else if days <= 7 {
            return "Time to gather your forces."
        } else {
            return "The realm is peaceful... for now."
        }
    }
} 