//
//  AchievementModels.swift
//  LandLord
//
//  Created for bunkeboyLandLord2
//  Medieval 8-bit themed real estate app
//

import Foundation

// MARK: - Achievement Type

/// Types of achievements that can be earned in the app
enum AchievementType: String, Codable, CaseIterable, Identifiable {
    // Onboarding achievements
    case firstLogin = "FirstLogin"               // First time logging in
    case profileComplete = "ProfileComplete"     // Completed profile setup
    case completeOnboarding = "CompleteOnboarding"
    
    // Quest achievements
    case firstQuest = "FirstQuest"               // Completed first quest
    case questMaster = "QuestMaster"             // Completed 50 quests
    case dailyQuestStreak = "DailyQuestStreak"   // Completed quests for X days in a row
    case weeklyQuestMaster = "WeeklyQuestMaster"
    case questCompletionist = "QuestCompletionist"
    
    // Listing achievements
    case firstListing = "FirstListing"           // Created first listing
    case listingMogul = "ListingMogul"           // Listed 10 properties
    case premiumLister = "PremiumLister"         // Listed a property worth over $1M
    case listingMaster = "ListingMaster"
    
    // Transaction achievements
    case firstSale = "FirstSale"                 // Completed first sale
    case closingMaster = "ClosingMaster"         // Closed 10 deals
    case millionDollarAgent = "MillionDollar"    // Reached $1M in sales volume
    case bigSale = "BigSale"
    case salesMaster = "SalesMaster"
    
    // Gold achievements
    case goldCollector = "GoldCollector"         // Earned 1,000 gold
    case goldHoarder = "GoldHoarder"             // Earned 10,000 gold
    case royalTreasury = "RoyalTreasury"         // Earned 100,000 gold
    case wealthyNoble = "WealthyNoble"
    case royalFortune = "RoyalFortune"
    
    // Streak achievements
    case weekStreak = "WeekStreak"               // 7-day streak
    case monthStreak = "MonthStreak"             // 30-day streak
    case seasonStreak = "SeasonStreak"           // 90-day streak
    
    // Level achievements
    case knighthood = "Knighthood"               // Reached Knight rank
    case barony = "Barony"                       // Reached Baron rank
    case dukedom = "Dukedom"                     // Reached Duke rank
    case royalty = "Royalty"                     // Reached Royalty rank
    case reachLevel10 = "ReachLevel10"
    case reachLevel25 = "ReachLevel25"
    case reachLevel50 = "ReachLevel50"
    
    /// Get the category for this achievement type
    var category: AchievementCategory {
        switch self {
        case .firstLogin, .profileComplete, .completeOnboarding:
            return .onboarding
        case .firstQuest, .questMaster, .dailyQuestStreak, .weeklyQuestMaster, .questCompletionist:
            return .quests
        case .firstListing, .listingMogul, .premiumLister, .listingMaster:
            return .listings
        case .firstSale, .closingMaster, .millionDollarAgent, .bigSale, .salesMaster:
            return .transactions
        case .goldCollector, .goldHoarder, .royalTreasury, .wealthyNoble, .royalFortune:
            return .gold
        case .weekStreak, .monthStreak, .seasonStreak:
            return .streaks
        case .knighthood, .barony, .dukedom, .royalty, .reachLevel10, .reachLevel25, .reachLevel50:
            return .levels
        }
    }
    
    /// Get the display name for this achievement type
    var displayName: String {
        switch self {
        case .firstLogin:
            return "Royal Welcome"
        case .profileComplete:
            return "Identity Established"
        case .firstQuest:
            return "Squire's First Quest"
        case .questMaster:
            return "Royal Taskmaster"
        case .dailyQuestStreak:
            return "Loyal Subject"
        case .weeklyQuestMaster:
            return "Quest Champion"
        case .questCompletionist:
            return "Quest Completionist"
        case .firstListing:
            return "Property Herald"
        case .listingMogul:
            return "Territory Expander"
        case .premiumLister:
            return "Royal Estate Manager"
        case .firstSale:
            return "First Transaction"
        case .closingMaster:
            return "Master Negotiator"
        case .millionDollarAgent:
            return "Million Gold Agent"
        case .bigSale:
            return "Castle Dealer"
        case .salesMaster:
            return "Master Merchant"
        case .goldCollector:
            return "Gold Collector"
        case .goldHoarder:
            return "Dragon's Hoard"
        case .royalTreasury:
            return "Royal Treasury"
        case .weekStreak:
            return "Week of Dedication"
        case .monthStreak:
            return "Month of Loyalty"
        case .seasonStreak:
            return "Season of Devotion"
        case .knighthood:
            return "Knighthood Achieved"
        case .barony:
            return "Barony Claimed"
        case .dukedom:
            return "Dukedom Established"
        case .royalty:
            return "Royalty Ascended"
        case .reachLevel10:
            return "Rising Knight"
        case .reachLevel25:
            return "Established Noble"
        case .reachLevel50:
            return "Legendary Royalty"
        }
    }
    
    /// Description of how to earn the achievement
    var description: String {
        switch self {
        case .firstLogin:
            return "Enter the realm for the first time"
        case .firstQuest:
            return "Complete thy first royal quest"
        case .completeOnboarding:
            return "Complete the knightly initiation"
        case .dailyQuestStreak:
            return "Complete daily quests for 7 days in a row"
        case .weeklyQuestMaster:
            return "Complete all weekly quests for 4 weeks"
        case .questCompletionist:
            return "Complete 100 quests in total"
        case .firstListing:
            return "List thy first property in the marketplace"
        case .listingMogul:
            return "List 10 properties"
        case .premiumLister:
            return "List 10 premium properties"
        case .firstSale:
            return "Complete thy first property sale"
        case .closingMaster:
            return "Close 10 deals"
        case .millionDollarAgent:
            return "Reach $1M in sales volume"
        case .bigSale:
            return "Sell a property worth over 1000 gold"
        case .salesMaster:
            return "Complete 25 property sales"
        case .goldCollector:
            return "Earn 1,000 gold"
        case .goldHoarder:
            return "Accumulate 500 gold in thy treasury"
        case .royalTreasury:
            return "Accumulate 100,000 gold in thy treasury"
        case .weekStreak:
            return "Use the app for 7 consecutive days"
        case .monthStreak:
            return "Use the app for 30 consecutive days"
        case .seasonStreak:
            return "Use the app for 90 consecutive days"
        case .knighthood:
            return "Reach Knight rank"
        case .barony:
            return "Reach Baron rank"
        case .dukedom:
            return "Reach Duke rank"
        case .royalty:
            return "Reach Royalty rank"
        case .reachLevel10:
            return "Attain the rank of level 10"
        case .reachLevel25:
            return "Attain the rank of level 25"
        case .reachLevel50:
            return "Attain the rank of level 50"
        }
    }
    
    var id: String { self.rawValue }
}

// MARK: - Achievement Category

/// Categories for grouping achievements
enum AchievementCategory: String, Codable, CaseIterable {
    case onboarding = "Onboarding"
    case quests = "Quests"
    case listings = "Listings"
    case transactions = "Transactions"
    case gold = "Gold"
    case streaks = "Streaks"
    case levels = "Levels"
    
    /// Get the display name for this category
    var displayName: String {
        switch self {
        case .onboarding:
            return "Royal Beginnings"
        case .quests:
            return "Noble Quests"
        case .listings:
            return "Territory Claims"
        case .transactions:
            return "Royal Decrees"
        case .gold:
            return "Treasury"
        case .streaks:
            return "Loyal Service"
        case .levels:
            return "Noble Ranks"
        }
    }
    
    /// Get the icon for this category
    var icon: String {
        switch self {
        case .onboarding:
            return "person.fill"
        case .quests:
            return "scroll.fill"
        case .listings:
            return "flag.fill"
        case .transactions:
            return "checkmark.seal.fill"
        case .gold:
            return "coins.fill"
        case .streaks:
            return "flame.fill"
        case .levels:
            return "crown.fill"
        }
    }
}

// MARK: - Achievement Model

/// Represents an achievement earned by a user
struct Achievement: Identifiable, Codable, Equatable {
    /// Unique identifier
    var id: String
    
    /// ID of the user who earned this achievement
    var userId: String
    
    /// Type of achievement
    var type: AchievementType
    
    /// Date when the achievement was earned
    var earnedDate: Date
    
    /// Additional metadata about the achievement (e.g., streak days, gold amount)
    var metadata: [String: String]
    
    /// Whether the achievement has been viewed by the user
    var isNew: Bool
    
    /// Default initializer
    init(id: String = UUID().uuidString,
         userId: String,
         type: AchievementType,
         earnedDate: Date = Date(),
         metadata: [String: String] = [:],
         isNew: Bool = true) {
        self.id = id
        self.userId = userId
        self.type = type
        self.earnedDate = earnedDate
        self.metadata = metadata
        self.isNew = isNew
    }
    
    /// Get the badge for this achievement
    var badge: Badge {
        return Badge.getBadge(for: type)
    }
    
    /// Get the progress value from metadata if available
    var progressValue: Int? {
        if let progressString = metadata["progress"], let progress = Int(progressString) {
            return progress
        }
        return nil
    }
    
    /// Get the target value from metadata if available
    var targetValue: Int? {
        if let targetString = metadata["target"], let target = Int(targetString) {
            return target
        }
        return nil
    }
}

// MARK: - Badge Model

/// Represents a visual badge awarded for achievements
struct Badge: Identifiable, Codable, Equatable {
    /// Unique identifier (same as achievement type)
    var id: String
    
    /// Display name of the badge
    var name: String
    
    /// Description of how to earn the badge
    var description: String
    
    /// Name of the image asset for the badge
    var imageName: String
    
    /// Rarity of the badge
    var rarity: BadgeRarity
    
    /// Gold reward for earning the badge
    var goldReward: Int
    
    /// Default initializer
    init(id: String,
         name: String,
         description: String,
         imageName: String,
         rarity: BadgeRarity,
         goldReward: Int) {
        self.id = id
        self.name = name
        self.description = description
        self.imageName = imageName
        self.rarity = rarity
        self.goldReward = goldReward
    }
    
    /// Get the appropriate badge for an achievement type
    static func getBadge(for achievementType: AchievementType) -> Badge {
        // Look up in the predefined badges
        if let badge = allBadges.first(where: { $0.id == achievementType.rawValue }) {
            return badge
        }
        
        // Fallback badge if not found
        return Badge(
            id: achievementType.rawValue,
            name: achievementType.displayName,
            description: "Earn this badge by completing a special achievement.",
            imageName: "badge_default",
            rarity: .common,
            goldReward: 50
        )
    }
    
    /// Get the system image name for this badge
    var systemImageName: String {
        // In a real app, we would use custom images
        // For now, use system images based on achievement category
        switch AchievementType(rawValue: id) {
        case .firstLogin, .profileComplete:
            return "person.fill.checkmark"
        case .firstQuest, .questMaster, .dailyQuestStreak:
            return "scroll.fill"
        case .firstListing, .listingMogul, .premiumLister:
            return "house.fill"
        case .firstSale, .closingMaster, .millionDollarAgent:
            return "checkmark.seal.fill"
        case .goldCollector, .goldHoarder, .royalTreasury:
            return "coins.fill"
        case .weekStreak, .monthStreak, .seasonStreak:
            return "flame.fill"
        case .knighthood:
            return "shield.fill"
        case .barony:
            return "flag.fill"
        case .dukedom:
            return "crown.fill"
        case .royalty:
            return "star.fill"
        default:
            return "medal.fill"
        }
    }
}

// MARK: - Badge Rarity

/// Represents the rarity level of a badge
enum BadgeRarity: String, Codable, CaseIterable {
    case common = "Common"
    case uncommon = "Uncommon"
    case rare = "Rare"
    case epic = "Epic"
    case legendary = "Legendary"
    
    /// Get the color for this rarity level
    var color: String {
        switch self {
        case .common:
            return "#808080" // Gray
        case .uncommon:
            return "#00AA00" // Green
        case .rare:
            return "#0070DD" // Blue
        case .epic:
            return "#A335EE" // Purple
        case .legendary:
            return "#FF8000" // Orange
        }
    }
    
    /// Get the display name for this rarity
    var displayName: String {
        switch self {
        case .common:
            return "Common"
        case .uncommon:
            return "Uncommon"
        case .rare:
            return "Rare"
        case .epic:
            return "Epic"
        case .legendary:
            return "Legendary"
        }
    }
}

// MARK: - Sample Data

/// Sample collection of all possible badges
let allBadges: [Badge] = [
    // Onboarding badges
    Badge(
        id: AchievementType.firstLogin.rawValue,
        name: "Royal Welcome",
        description: "Welcome to the kingdom! You've taken your first step into the realm of real estate.",
        imageName: "badge_first_login",
        rarity: .common,
        goldReward: 50
    ),
    Badge(
        id: AchievementType.profileComplete.rawValue,
        name: "Identity Established",
        description: "You've established your royal identity by completing your profile.",
        imageName: "badge_profile_complete",
        rarity: .common,
        goldReward: 100
    ),
    
    // Quest badges
    Badge(
        id: AchievementType.firstQuest.rawValue,
        name: "Squire's First Quest",
        description: "You've completed your first quest. Many more adventures await!",
        imageName: "badge_first_quest",
        rarity: .common,
        goldReward: 50
    ),
    Badge(
        id: AchievementType.questMaster.rawValue,
        name: "Royal Taskmaster",
        description: "A true hero of the realm! You've completed 50 quests.",
        imageName: "badge_quest_master",
        rarity: .epic,
        goldReward: 500
    ),
    Badge(
        id: AchievementType.dailyQuestStreak.rawValue,
        name: "Loyal Subject",
        description: "Your dedication is unmatched. You've completed quests for 10 days in a row.",
        imageName: "badge_daily_streak",
        rarity: .rare,
        goldReward: 200
    ),
    
    // Listing badges
    Badge(
        id: AchievementType.firstListing.rawValue,
        name: "Property Herald",
        description: "You've staked your first claim by listing a property.",
        imageName: "badge_first_listing",
        rarity: .common,
        goldReward: 100
    ),
    Badge(
        id: AchievementType.listingMogul.rawValue,
        name: "Territory Expander",
        description: "Your influence grows! You've listed 10 properties.",
        imageName: "badge_listing_mogul",
        rarity: .rare,
        goldReward: 300
    ),
    Badge(
        id: AchievementType.premiumLister.rawValue,
        name: "Royal Estate Manager",
        description: "Only the finest estates! You've listed a property worth over $1M.",
        imageName: "badge_premium_lister",
        rarity: .epic,
        goldReward: 500
    ),
    
    // Transaction badges
    Badge(
        id: AchievementType.firstSale.rawValue,
        name: "First Transaction",
        description: "You've closed your first deal. The first of many conquests!",
        imageName: "badge_first_sale",
        rarity: .common,
        goldReward: 100
    ),
    Badge(
        id: AchievementType.closingMaster.rawValue,
        name: "Master Negotiator",
        description: "A skilled diplomat! You've closed 10 deals.",
        imageName: "badge_closing_master",
        rarity: .rare,
        goldReward: 300
    ),
    Badge(
        id: AchievementType.millionDollarAgent.rawValue,
        name: "Million Gold Agent",
        description: "Your wealth is legendary! You've reached $1M in sales volume.",
        imageName: "badge_million_dollar",
        rarity: .legendary,
        goldReward: 1000
    ),
    
    // Gold badges
    Badge(
        id: AchievementType.goldCollector.rawValue,
        name: "Gold Collector",
        description: "Your coffers begin to fill. You've earned 1,000 gold.",
        imageName: "badge_gold_collector",
        rarity: .uncommon,
        goldReward: 100
    ),
    Badge(
        id: AchievementType.goldHoarder.rawValue,
        name: "Dragon's Hoard",
        description: "Your wealth rivals that of dragons! You've earned 10,000 gold.",
        imageName: "badge_gold_hoarder",
        rarity: .rare,
        goldReward: 500
    ),
    Badge(
        id: AchievementType.royalTreasury.rawValue,
        name: "Royal Treasury",
        description: "Your wealth is the envy of kingdoms! You've earned 100,000 gold.",
        imageName: "badge_royal_treasury",
        rarity: .legendary,
        goldReward: 1000
    ),
    
    // Streak badges
    Badge(
        id: AchievementType.weekStreak.rawValue,
        name: "Week of Dedication",
        description: "A week of loyal service! You've maintained a 7-day streak.",
        imageName: "badge_week_streak",
        rarity: .uncommon,
        goldReward: 100
    ),
    Badge(
        id: AchievementType.monthStreak.rawValue,
        name: "Month of Loyalty",
        description: "A month of dedication! You've maintained a 30-day streak.",
        imageName: "badge_month_streak",
        rarity: .rare,
        goldReward: 300
    ),
    Badge(
        id: AchievementType.seasonStreak.rawValue,
        name: "Season of Devotion",
        description: "A season of unwavering commitment! You've maintained a 90-day streak.",
        imageName: "badge_season_streak",
        rarity: .epic,
        goldReward: 500
    ),
    
    // Level badges
    Badge(
        id: AchievementType.knighthood.rawValue,
        name: "Knighthood Achieved",
        description: "You've been knighted for your service to the realm.",
        imageName: "badge_knighthood",
        rarity: .uncommon,
        goldReward: 200
    ),
    Badge(
        id: AchievementType.barony.rawValue,
        name: "Barony Claimed",
        description: "Your influence grows! You've been granted the title of Baron.",
        imageName: "badge_barony",
        rarity: .rare,
        goldReward: 300
    ),
    Badge(
        id: AchievementType.dukedom.rawValue,
        name: "Dukedom Established",
        description: "Your power is recognized throughout the land! You've been granted the title of Duke.",
        imageName: "badge_dukedom",
        rarity: .epic,
        goldReward: 500
    ),
    Badge(
        id: AchievementType.royalty.rawValue,
        name: "Royalty Ascended",
        description: "The highest honor! You've ascended to Royalty status.",
        imageName: "badge_royalty",
        rarity: .legendary,
        goldReward: 1000
    ),
    Badge(
        id: AchievementType.reachLevel10.rawValue,
        name: "Rising Knight",
        description: "You've reached level 10!",
        imageName: "badge_reach_level_10",
        rarity: .uncommon,
        goldReward: 200
    ),
    Badge(
        id: AchievementType.reachLevel25.rawValue,
        name: "Established Noble",
        description: "You've reached level 25!",
        imageName: "badge_reach_level_25",
        rarity: .rare,
        goldReward: 300
    ),
    Badge(
        id: AchievementType.reachLevel50.rawValue,
        name: "Legendary Royalty",
        description: "You've reached level 50!",
        imageName: "badge_reach_level_50",
        rarity: .epic,
        goldReward: 500
    )
]

// MARK: - Achievement Requirements

/// Helper struct to define requirements for earning achievements
struct AchievementRequirement {
    /// The type of achievement
    let type: AchievementType
    
    /// The value required to earn the achievement (e.g., number of quests, gold amount)
    let requiredValue: Int
    
    /// Description of how to earn the achievement
    let description: String
}

/// Sample collection of achievement requirements
let achievementRequirements: [AchievementRequirement] = [
    // Onboarding achievements
    AchievementRequirement(
        type: .firstLogin,
        requiredValue: 1,
        description: "Log in to the app for the first time"
    ),
    AchievementRequirement(
        type: .profileComplete,
        requiredValue: 1,
        description: "Complete your profile information"
    ),
    
    // Quest achievements
    AchievementRequirement(
        type: .firstQuest,
        requiredValue: 1,
        description: "Complete your first quest"
    ),
    AchievementRequirement(
        type: .questMaster,
        requiredValue: 50,
        description: "Complete 50 quests"
    ),
    AchievementRequirement(
        type: .dailyQuestStreak,
        requiredValue: 10,
        description: "Complete quests for 10 days in a row"
    ),
    
    // Listing achievements
    AchievementRequirement(
        type: .firstListing,
        requiredValue: 1,
        description: "Create your first property listing"
    ),
    AchievementRequirement(
        type: .listingMogul,
        requiredValue: 10,
        description: "List 10 properties"
    ),
    AchievementRequirement(
        type: .premiumLister,
        requiredValue: 1000000,
        description: "List a property worth over $1M"
    ),
    
    // Transaction achievements
    AchievementRequirement(
        type: .firstSale,
        requiredValue: 1,
        description: "Close your first deal"
    ),
    AchievementRequirement(
        type: .closingMaster,
        requiredValue: 10,
        description: "Close 10 deals"
    ),
    AchievementRequirement(
        type: .millionDollarAgent,
        requiredValue: 1000000,
        description: "Reach $1M in sales volume"
    ),
    
    // Gold achievements
    AchievementRequirement(
        type: .goldCollector,
        requiredValue: 1000,
        description: "Earn 1,000 gold"
    ),
    AchievementRequirement(
        type: .goldHoarder,
        requiredValue: 10000,
        description: "Earn 10,000 gold"
    ),
    AchievementRequirement(
        type: .royalTreasury,
        requiredValue: 100000,
        description: "Earn 100,000 gold"
    ),
    
    // Streak achievements
    AchievementRequirement(
        type: .weekStreak,
        requiredValue: 7,
        description: "Maintain a 7-day streak"
    ),
    AchievementRequirement(
        type: .monthStreak,
        requiredValue: 30,
        description: "Maintain a 30-day streak"
    ),
    AchievementRequirement(
        type: .seasonStreak,
        requiredValue: 90,
        description: "Maintain a 90-day streak"
    ),
    
    // Level achievements
    AchievementRequirement(
        type: .knighthood,
        requiredValue: 1,
        description: "Reach Knight rank"
    ),
    AchievementRequirement(
        type: .barony,
        requiredValue: 1,
        description: "Reach Baron rank"
    ),
    AchievementRequirement(
        type: .dukedom,
        requiredValue: 1,
        description: "Reach Duke rank"
    ),
    AchievementRequirement(
        type: .royalty,
        requiredValue: 1,
        description: "Reach Royalty rank"
    ),
    AchievementRequirement(
        type: .reachLevel10,
        requiredValue: 10,
        description: "Reach level 10"
    ),
    AchievementRequirement(
        type: .reachLevel25,
        requiredValue: 25,
        description: "Reach level 25"
    ),
    AchievementRequirement(
        type: .reachLevel50,
        requiredValue: 50,
        description: "Reach level 50"
    )
] 