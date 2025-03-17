//
//  QuestsViewModel.swift
//  LandLord
//
//  Created for bunkeboyLandLord2
//  Medieval 8-bit themed real estate app
//

import SwiftUI
import Combine

// MARK: - Activity Type Enum
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

// MARK: - Quest Type Enum
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
    var type: QuestType
    
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
         type: QuestType,
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

class QuestsViewModel: ObservableObject {
    // Published array of quests
    @Published var quests: [Quest] = []
    
    // Shield count (lives)
    @Published var shieldCount: Int = 3
    
    // Maximum shield count
    let maxShieldCount: Int = 3
    
    // User ID for quests
    private let userId: String
    
    // Initialize with user ID
    init(userId: String = "user123") {
        self.userId = userId
        loadDailyQuests()
    }
    
    // Load daily quests
    func loadDailyQuests() {
        // In a real app, this would fetch from a database
        // For now, populate with sample quests
        quests = generateSampleQuests()
    }
    
    // Mark a quest as completed
    func completeQuest(id: String) {
        if let index = quests.firstIndex(where: { $0.id == id }) {
            // Update the quest status
            var updatedQuest = quests[index]
            updatedQuest.status = .completed
            
            // Update the quest in the array
            quests[index] = updatedQuest
            
            // In a real app, this would update the database
            print("Quest completed: \(updatedQuest.title)")
            
            // Notify any listeners about the change
            objectWillChange.send()
        }
    }
    
    // Calculate total gold earned from completed quests
    func calculateGoldEarned() -> Int {
        return quests
            .filter { $0.status == .completed }
            .reduce(0) { $0 + $1.goldReward }
    }
    
    // Calculate total experience earned from completed quests
    func calculateExperienceEarned() -> Int {
        return quests
            .filter { $0.status == .completed }
            .reduce(0) { $0 + $1.experienceReward }
    }
    
    // Generate sample quests
    private func generateSampleQuests() -> [Quest] {
        return [
            Quest(
                id: UUID().uuidString,
                userId: userId,
                title: "List a New Property",
                description: "Claim new land for thy kingdom by listing a property for sale.",
                type: .property,
                status: .notStarted,
                date: Date(),
                goldReward: 50,
                experienceReward: 25,
                isSpecialQuest: false
            ),
            Quest(
                id: UUID().uuidString,
                userId: userId,
                title: "Host an Open House",
                description: "Open thy castle gates and welcome potential buyers to view the property.",
                type: .property,
                status: .notStarted,
                date: Date(),
                goldReward: 30,
                experienceReward: 15,
                isSpecialQuest: false
            ),
            Quest(
                id: UUID().uuidString,
                userId: userId,
                title: "Follow Up with Prospects",
                description: "Send royal messengers to follow up with potential buyers.",
                type: .property,
                status: .notStarted,
                date: Date(),
                goldReward: 20,
                experienceReward: 10,
                isSpecialQuest: false
            ),
            Quest(
                id: UUID().uuidString,
                userId: userId,
                title: "Complete Market Analysis",
                description: "Study the scrolls of market data to determine fair property values.",
                type: .property,
                status: .notStarted,
                date: Date(),
                goldReward: 35,
                experienceReward: 20,
                isSpecialQuest: false
            ),
            Quest(
                id: UUID().uuidString,
                userId: userId,
                title: "Submit an Offer",
                description: "Present a treaty proposal to acquire new land for thy client.",
                type: .special,
                status: .notStarted,
                date: Date(),
                goldReward: 45,
                experienceReward: 30,
                isSpecialQuest: true
            )
        ]
    }
    
    // Generate a random quest
    func generateRandomQuest() -> Quest {
        // Random activity type for quest content
        let activityTypes: [ActivityType] = [.listing, .showing, .offer, .closing, .prospecting, .training, .marketing]
        let randomActivityType = activityTypes.randomElement() ?? .training
        
        // Random gold and XP rewards based on difficulty
        let baseGold = 20
        let baseXP = 10
        let difficultyMultiplier = randomActivityType.difficultyLevel
        let goldReward = baseGold * difficultyMultiplier
        let xpReward = baseXP * difficultyMultiplier
        
        // Random chance for special quest (10%)
        let isSpecial = Int.random(in: 1...10) == 1
        
        // Quest titles and descriptions based on activity type
        let (title, description) = questTitleAndDescription(for: randomActivityType)
        
        // Determine quest type (mostly property, but some daily/weekly/special)
        let questType: QuestType = isSpecial ? .special : .property
        
        return Quest(
            id: UUID().uuidString,
            userId: userId,
            title: title,
            description: description,
            type: questType,
            status: .notStarted,
            date: Date(),
            goldReward: isSpecial ? goldReward * 2 : goldReward,
            experienceReward: isSpecial ? xpReward * 2 : xpReward,
            isSpecialQuest: isSpecial
        )
    }
    
    // Generate a set of random quests
    func generateRandomQuests(count: Int) -> [Quest] {
        var randomQuests: [Quest] = []
        
        for _ in 0..<count {
            randomQuests.append(generateRandomQuest())
        }
        
        return randomQuests
    }
    
    // Refresh quests with new random ones
    func refreshQuests() {
        quests = generateRandomQuests(count: 5)
        objectWillChange.send()
    }
    
    // Helper method to get title and description for quest type
    private func questTitleAndDescription(for type: ActivityType) -> (String, String) {
        switch type {
        case .listing:
            return (
                "Claim New Territory",
                "List a new property in thy kingdom to expand thy influence."
            )
        case .showing:
            return (
                "Royal Tour of the Castle",
                "Show potential buyers the grand features of thy property."
            )
        case .offer:
            return (
                "Negotiate a Treaty",
                "Present or review an offer for property acquisition."
            )
        case .closing:
            return (
                "Seal the Royal Decree",
                "Complete the final paperwork to transfer property ownership."
            )
        case .prospecting:
            return (
                "Scout for New Allies",
                "Find potential clients who seek to buy or sell property."
            )
        case .training:
            return (
                "Study the Ancient Scrolls",
                "Complete training to improve thy real estate knowledge."
            )
        case .marketing:
            return (
                "Dispatch the Town Crier",
                "Create marketing materials to promote thy listings."
            )
        }
    }
    
    // Use a shield (life)
    func useShield() -> Bool {
        if shieldCount > 0 {
            shieldCount -= 1
            return true
        }
        return false
    }
    
    // Restore a shield (life)
    func restoreShield() {
        if shieldCount < maxShieldCount {
            shieldCount += 1
        }
    }
    
    // Restore all shields (lives)
    func restoreAllShields() {
        shieldCount = maxShieldCount
    }
} 