//
//  GameMechanicsModel.swift
//  LandLord
//
//  Created for bunkeboyLandLord2
//  Medieval 8-bit themed real estate app
//

import Foundation

/// Model for handling game mechanics and progression systems
struct GameMechanicsModel {
    
    // MARK: - Shield/Heart Constants
    
    /// Maximum number of shields (lives) a player can have
    static let maxShields: Int = 3
    
    /// Maximum number of heart points a player can have
    static let maxHearts: Int = 5
    
    /// Hours required for a shield to regenerate
    static let shieldRegenerationHours: Int = 4
    
    /// Hours required for a heart to regenerate
    static let heartRegenerationHours: Int = 2
    
    // MARK: - Level Progression
    
    /// XP required for each level
    static let xpPerLevel: Int = 100
    
    /// Maximum level a player can reach
    static let maxLevel: Int = 50
    
    /// Ranks available to players as they progress
    static let ranks: [UserRank] = [
        .squire,    // Beginner
        .knight,    // Intermediate
        .baron,     // Advanced
        .duke,      // Expert
        .royalty    // Master
    ]
    
    /// Titles for each level within ranks
    static let titlePrefixes: [String] = [
        "Novice",
        "Apprentice",
        "Skilled",
        "Veteran",
        "Master",
        "Grand",
        "Royal",
        "Legendary",
        "Mythical",
        "Divine"
    ]
    
    // MARK: - Reward Constants
    
    /// Base gold reward for completing a quest
    static let baseGoldReward: Int = 20
    
    /// Base XP reward for completing a quest
    static let baseXPReward: Int = 10
    
    /// Multiplier for special quests
    static let specialQuestMultiplier: Double = 2.0
    
    /// Gold bonus per day of streak
    static let goldPerStreakDay: Int = 5
    
    /// Maximum streak bonus (caps at 50 days)
    static let maxStreakDays: Int = 50
    
    /// XP bonus per day of streak
    static let xpPerStreakDay: Int = 2
    
    // MARK: - Gold Calculation
    
    /// Calculate gold reward for a quest based on its type and difficulty
    /// - Parameter quest: The quest to calculate reward for
    /// - Returns: The gold reward amount
    static func calculateReward(for quest: Quest) -> Int {
        let difficultyMultiplier = quest.type.difficultyLevel
        var reward = baseGoldReward * difficultyMultiplier
        
        // Apply special quest bonus if applicable
        if quest.isSpecialQuest {
            reward = Int(Double(reward) * specialQuestMultiplier)
        }
        
        return reward
    }
    
    /// Calculate XP reward for a quest based on its type and difficulty
    /// - Parameter quest: The quest to calculate XP for
    /// - Returns: The XP reward amount
    static func calculateXP(for quest: Quest) -> Int {
        let difficultyMultiplier = quest.type.difficultyLevel
        var xp = baseXPReward * difficultyMultiplier
        
        // Apply special quest bonus if applicable
        if quest.isSpecialQuest {
            xp = Int(Double(xp) * specialQuestMultiplier)
        }
        
        return xp
    }
    
    /// Calculate bonus gold for a streak of consecutive days
    /// - Parameter days: Number of consecutive days
    /// - Returns: Bonus gold amount
    static func streakBonus(days: Int) -> Int {
        let cappedDays = min(days, maxStreakDays)
        return cappedDays * goldPerStreakDay
    }
    
    /// Calculate bonus XP for a streak of consecutive days
    /// - Parameter days: Number of consecutive days
    /// - Returns: Bonus XP amount
    static func streakXPBonus(days: Int) -> Int {
        let cappedDays = min(days, maxStreakDays)
        return cappedDays * xpPerStreakDay
    }
    
    // MARK: - Level Calculation
    
    /// Calculate level based on XP
    /// - Parameter xp: Experience points
    /// - Returns: Current level
    static func calculateLevel(xp: Int) -> Int {
        let level = (xp / xpPerLevel) + 1
        return min(level, maxLevel)
    }
    
    /// Calculate XP required for the next level
    /// - Parameter currentXP: Current experience points
    /// - Returns: XP required for next level
    static func xpForNextLevel(currentXP: Int) -> Int {
        let currentLevel = calculateLevel(xp: currentXP)
        
        // If at max level, return 0
        if currentLevel >= maxLevel {
            return 0
        }
        
        // Calculate XP needed for next level
        let nextLevelXP = currentLevel * xpPerLevel
        return nextLevelXP - currentXP
    }
    
    /// Calculate progress percentage toward next level
    /// - Parameter currentXP: Current experience points
    /// - Returns: Percentage (0-100) toward next level
    static func levelProgress(currentXP: Int) -> Double {
        let currentLevel = calculateLevel(xp: currentXP)
        
        // If at max level, return 100%
        if currentLevel >= maxLevel {
            return 100.0
        }
        
        // Calculate progress within current level
        let levelStartXP = (currentLevel - 1) * xpPerLevel
        let nextLevelXP = currentLevel * xpPerLevel
        let xpInCurrentLevel = currentXP - levelStartXP
        let xpRequiredForLevel = nextLevelXP - levelStartXP
        
        return (Double(xpInCurrentLevel) / Double(xpRequiredForLevel)) * 100.0
    }
    
    /// Get the rank for a given XP amount
    /// - Parameter xp: Experience points
    /// - Returns: The user's rank
    static func rankForXP(_ xp: Int) -> UserRank {
        for rank in ranks.reversed() {
            if xp >= rank.requiredXP {
                return rank
            }
        }
        return .squire // Default to lowest rank
    }
    
    /// Get the next rank for a given XP amount
    /// - Parameter xp: Experience points
    /// - Returns: The next rank or nil if at max rank
    static func nextRankForXP(_ xp: Int) -> UserRank? {
        let currentRank = rankForXP(xp)
        guard let currentIndex = ranks.firstIndex(of: currentRank) else {
            return nil
        }
        
        let nextIndex = currentIndex + 1
        guard nextIndex < ranks.count else {
            return nil // Already at highest rank
        }
        
        return ranks[nextIndex]
    }
    
    /// Get the full title for a given XP amount
    /// - Parameter xp: Experience points
    /// - Returns: The user's full title
    static func titleForXP(_ xp: Int) -> String {
        let level = calculateLevel(xp: xp)
        let rank = rankForXP(xp)
        
        // Calculate which prefix to use based on level within rank
        let prefixIndex = min((level / 5) % titlePrefixes.count, titlePrefixes.count - 1)
        let prefix = titlePrefixes[prefixIndex]
        
        return "\(prefix) \(rank.rawValue)"
    }
    
    // MARK: - Shield/Heart Regeneration
    
    /// Calculate when the next shield will regenerate
    /// - Parameters:
    ///   - currentShields: Current shield count
    ///   - lastShieldLostTime: Time when the last shield was lost
    /// - Returns: Date when next shield will regenerate, or nil if shields are full
    static func nextShieldRegenerationTime(currentShields: Int, lastShieldLostTime: Date) -> Date? {
        // If shields are full, return nil
        if currentShields >= maxShields {
            return nil
        }
        
        // Calculate regeneration time
        return lastShieldLostTime.addingTimeInterval(Double(shieldRegenerationHours) * 3600)
    }
    
    /// Calculate when the next heart will regenerate
    /// - Parameters:
    ///   - currentHearts: Current heart count
    ///   - lastHeartLostTime: Time when the last heart was lost
    /// - Returns: Date when next heart will regenerate, or nil if hearts are full
    static func nextHeartRegenerationTime(currentHearts: Int, lastHeartLostTime: Date) -> Date? {
        // If hearts are full, return nil
        if currentHearts >= maxHearts {
            return nil
        }
        
        // Calculate regeneration time
        return lastHeartLostTime.addingTimeInterval(Double(heartRegenerationHours) * 3600)
    }
    
    /// Check if a shield should be regenerated based on time elapsed
    /// - Parameters:
    ///   - currentShields: Current shield count
    ///   - lastShieldLostTime: Time when the last shield was lost
    /// - Returns: Whether a shield should be regenerated
    static func shouldRegenerateShield(currentShields: Int, lastShieldLostTime: Date) -> Bool {
        // If shields are full, no regeneration needed
        if currentShields >= maxShields {
            return false
        }
        
        // Calculate time elapsed since last shield was lost
        let timeElapsed = Date().timeIntervalSince(lastShieldLostTime)
        let requiredTime = Double(shieldRegenerationHours) * 3600
        
        return timeElapsed >= requiredTime
    }
    
    /// Check if a heart should be regenerated based on time elapsed
    /// - Parameters:
    ///   - currentHearts: Current heart count
    ///   - lastHeartLostTime: Time when the last heart was lost
    /// - Returns: Whether a heart should be regenerated
    static func shouldRegenerateHeart(currentHearts: Int, lastHeartLostTime: Date) -> Bool {
        // If hearts are full, no regeneration needed
        if currentHearts >= maxHearts {
            return false
        }
        
        // Calculate time elapsed since last heart was lost
        let timeElapsed = Date().timeIntervalSince(lastHeartLostTime)
        let requiredTime = Double(heartRegenerationHours) * 3600
        
        return timeElapsed >= requiredTime
    }
    
    // MARK: - Streak Calculation
    
    /// Check if a streak is still active
    /// - Parameters:
    ///   - lastActiveDate: The last date the user was active
    ///   - currentDate: The current date
    /// - Returns: Whether the streak is still active
    static func isStreakActive(lastActiveDate: Date, currentDate: Date = Date()) -> Bool {
        let calendar = Calendar.current
        
        // Get the start of day for both dates
        let lastActiveDay = calendar.startOfDay(for: lastActiveDate)
        let currentDay = calendar.startOfDay(for: currentDate)
        
        // Calculate days between
        let components = calendar.dateComponents([.day], from: lastActiveDay, to: currentDay)
        guard let days = components.day else { return false }
        
        // Streak is active if user was active yesterday or today
        return days <= 1
    }
    
    /// Calculate the streak bonus description
    /// - Parameter streakDays: Number of consecutive days
    /// - Returns: A medieval-themed description of the streak
    static func streakDescription(streakDays: Int) -> String {
        switch streakDays {
        case 0:
            return "Thy quest has not yet begun."
        case 1:
            return "Thy first day of conquest."
        case 2...6:
            return "A noble effort of \(streakDays) days."
        case 7...13:
            return "A week's campaign of \(streakDays) days."
        case 14...29:
            return "A fortnight's crusade of \(streakDays) days."
        case 30...99:
            return "A month's siege of \(streakDays) days."
        default:
            return "A legendary conquest of \(streakDays) days!"
        }
    }
    
    // MARK: - Achievement Calculation
    
    /// Calculate achievement progress percentage
    /// - Parameters:
    ///   - current: Current progress value
    ///   - target: Target value for completion
    /// - Returns: Percentage of completion (0-100)
    static func achievementProgress(current: Double, target: Double) -> Double {
        guard target > 0 else { return 0 }
        return min(100.0, (current / target) * 100.0)
    }
    
    /// Get medieval-themed description of achievement progress
    /// - Parameter percentage: Progress percentage (0-100)
    /// - Returns: Medieval-themed description
    static func achievementDescription(percentage: Double) -> String {
        switch percentage {
        case 0:
            return "Thy quest awaits."
        case 0.1...25:
            return "The journey has just begun."
        case 25.1...50:
            return "Halfway to glory!"
        case 50.1...75:
            return "Victory is within sight!"
        case 75.1...99.9:
            return "The final battle approaches!"
        case 100:
            return "The kingdom is yours!"
        default:
            return "Unknown progress."
        }
    }
} 