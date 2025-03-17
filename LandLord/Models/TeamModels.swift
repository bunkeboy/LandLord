//
//  TeamModels.swift
//  LandLord
//
//  Created for bunkeboyLandLord2
//  Medieval 8-bit themed real estate app
//

import Foundation

// MARK: - Team Model

/// Represents a team of real estate agents in the medieval realm
struct Team: Codable, Identifiable {
    /// Unique identifier for the team
    let id: UUID
    
    /// The name of the team (e.g., "Dragon Slayers Realty")
    var name: String
    
    /// ID of the team leader
    var leaderId: UUID
    
    /// IDs of all team members
    var memberIds: [UUID]
    
    /// Date when the team was created
    let createdAt: Date
    
    /// Optional team motto
    var motto: String?
    
    /// Optional team emblem image name
    var emblemImageName: String?
    
    /// Optional team territory (region of operation)
    var territory: String?
    
    // MARK: - Computed Properties
    
    /// Number of members in the team
    var teamSize: Int {
        return memberIds.count
    }
    
    /// Checks if the team is newly formed (less than 30 days old)
    var isNewlyFormed: Bool {
        let daysSinceCreation = DateHelpers.daysBetween(start: createdAt, end: Date())
        return daysSinceCreation < 30
    }
    
    /// Returns a medieval-styled creation date
    var medievalCreationDate: String {
        return createdAt.medievalFormat
    }
    
    // MARK: - Initialization
    
    init(id: UUID = UUID(), name: String, leaderId: UUID, memberIds: [UUID], createdAt: Date = Date(), motto: String? = nil, emblemImageName: String? = nil, territory: String? = nil) {
        self.id = id
        self.name = name
        self.leaderId = leaderId
        self.memberIds = memberIds
        self.createdAt = createdAt
        self.motto = motto
        self.emblemImageName = emblemImageName
        self.territory = territory
    }
}

// MARK: - Team Member Model

/// Represents a member of a team with additional team-specific properties
struct TeamMember: Codable, Identifiable {
    /// Unique identifier for the team member
    let id: UUID
    
    /// Reference to the base user
    var userId: UUID
    
    /// The member's name
    var name: String
    
    /// The member's rank or title within the team
    var rank: String
    
    /// Date when the member joined the team
    let joinedAt: Date
    
    /// Member's specialization (e.g., "Castle Sales", "Farmland Leasing")
    var specialization: String?
    
    /// Member's performance metrics
    var performance: TeamPerformance
    
    /// Whether this member is a team leader
    var isLeader: Bool
    
    /// Member's profile image name
    var profileImageName: String?
    
    /// Member's bio or description
    var bio: String?
    
    // MARK: - Computed Properties
    
    /// Number of days the member has been with the team
    var daysWithTeam: Int {
        return DateHelpers.daysBetween(start: joinedAt, end: Date())
    }
    
    /// Whether the member is a new recruit (less than 14 days)
    var isNewRecruit: Bool {
        return daysWithTeam < 14
    }
    
    /// Medieval-styled join date
    var medievalJoinDate: String {
        return joinedAt.medievalFormat
    }
    
    // MARK: - Initialization
    
    init(id: UUID = UUID(), userId: UUID, name: String, rank: String, joinedAt: Date = Date(), specialization: String? = nil, performance: TeamPerformance = TeamPerformance(), isLeader: Bool = false, profileImageName: String? = nil, bio: String? = nil) {
        self.id = id
        self.userId = userId
        self.name = name
        self.rank = rank
        self.joinedAt = joinedAt
        self.specialization = specialization
        self.performance = performance
        self.isLeader = isLeader
        self.profileImageName = profileImageName
        self.bio = bio
    }
}

// MARK: - Team Performance Model

/// Tracks performance metrics for team members
struct TeamPerformance: Codable {
    /// Properties sold in the last 30 days
    var propertiesSold: Int = 0
    
    /// Gold earned in the last 30 days
    var goldEarned: Int = 0
    
    /// Quests completed in the last 30 days
    var questsCompleted: Int = 0
    
    /// Customer satisfaction rating (1-5)
    var satisfactionRating: Double = 0.0
    
    /// Number of new clients acquired
    var newClients: Int = 0
    
    /// Special achievements or bonuses
    var achievements: [String] = []
    
    // MARK: - Computed Properties
    
    /// Overall performance score based on various metrics
    var overallScore: Double {
        let salesScore = Double(propertiesSold) * 10.0
        let goldScore = Double(goldEarned) / 100.0
        let questScore = Double(questsCompleted) * 5.0
        let satisfactionScore = satisfactionRating * 20.0
        let clientScore = Double(newClients) * 15.0
        
        let totalScore = salesScore + goldScore + questScore + satisfactionScore + clientScore
        return min(100.0, totalScore)
    }
    
    /// Performance rank based on overall score
    var performanceRank: String {
        switch overallScore {
        case 90...100:
            return "Legendary"
        case 75..<90:
            return "Master"
        case 60..<75:
            return "Expert"
        case 40..<60:
            return "Adept"
        case 20..<40:
            return "Apprentice"
        default:
            return "Novice"
        }
    }
    
    /// Returns a color name based on performance rank
    var rankColorName: String {
        switch performanceRank {
        case "Legendary":
            return "medievalGold"
        case "Master":
            return "royalPurple"
        case "Expert":
            return "forestGreen"
        case "Adept":
            return "medievalBlue"
        case "Apprentice":
            return "medievalBrown"
        default:
            return "stoneGray"
        }
    }
}

// MARK: - Team Manager

/// Manages team-related operations and calculations
struct TeamManager {
    /// Calculate the average performance of all team members
    /// - Parameter members: Array of team members
    /// - Returns: Average performance score
    static func calculateAveragePerformance(for members: [TeamMember]) -> Double {
        guard !members.isEmpty else { return 0.0 }
        
        let totalScore = members.reduce(0.0) { $0 + $1.performance.overallScore }
        return totalScore / Double(members.count)
    }
    
    /// Find the top performer in the team
    /// - Parameter members: Array of team members
    /// - Returns: The team member with the highest performance score, or nil if the array is empty
    static func findTopPerformer(in members: [TeamMember]) -> TeamMember? {
        return members.max(by: { $0.performance.overallScore < $1.performance.overallScore })
    }
    
    /// Calculate team level based on combined performance
    /// - Parameter members: Array of team members
    /// - Returns: Team level (1-10)
    static func calculateTeamLevel(for members: [TeamMember]) -> Int {
        guard !members.isEmpty else { return 1 }
        
        let averagePerformance = calculateAveragePerformance(for: members)
        return min(10, max(1, Int(averagePerformance / 10.0)))
    }
    
    /// Generate a team title based on team level
    /// - Parameter level: Team level (1-10)
    /// - Returns: Medieval-themed team title
    static func teamTitle(for level: Int) -> String {
        switch level {
        case 10:
            return "Royal Order"
        case 9:
            return "Noble House"
        case 8:
            return "Sovereign Guild"
        case 7:
            return "Esteemed Fellowship"
        case 6:
            return "Honored Company"
        case 5:
            return "Respected Brigade"
        case 4:
            return "Trusted Alliance"
        case 3:
            return "Rising Covenant"
        case 2:
            return "Aspiring League"
        default:
            return "Fledgling Band"
        }
    }
}

// MARK: - Sample Data

extension Team {
    /// Sample teams for testing and preview
    static var samples: [Team] = [
        Team(
            id: UUID(uuidString: "E621E1F8-C36C-495A-93FC-0C247A3E6E5F")!,
            name: "Dragon Slayers Realty",
            leaderId: UUID(uuidString: "F621E1F8-C36C-495A-93FC-0C247A3E6E5F")!,
            memberIds: [
                UUID(uuidString: "F621E1F8-C36C-495A-93FC-0C247A3E6E5F")!,
                UUID(uuidString: "G621E1F8-C36C-495A-93FC-0C247A3E6E5F")!,
                UUID(uuidString: "H621E1F8-C36C-495A-93FC-0C247A3E6E5F")!
            ],
            createdAt: Date().addingTimeInterval(-90 * 24 * 60 * 60), // 90 days ago
            motto: "Slaying the housing market, one castle at a time",
            emblemImageName: "dragon_shield",
            territory: "Northern Kingdoms"
        ),
        
        Team(
            id: UUID(uuidString: "A721E1F8-C36C-495A-93FC-0C247A3E6E5F")!,
            name: "Knights of the Round Estate",
            leaderId: UUID(uuidString: "B721E1F8-C36C-495A-93FC-0C247A3E6E5F")!,
            memberIds: [
                UUID(uuidString: "B721E1F8-C36C-495A-93FC-0C247A3E6E5F")!,
                UUID(uuidString: "C721E1F8-C36C-495A-93FC-0C247A3E6E5F")!,
                UUID(uuidString: "D721E1F8-C36C-495A-93FC-0C247A3E6E5F")!,
                UUID(uuidString: "E721E1F8-C36C-495A-93FC-0C247A3E6E5F")!
            ],
            createdAt: Date().addingTimeInterval(-180 * 24 * 60 * 60), // 180 days ago
            motto: "For honor, glory, and affordable housing",
            emblemImageName: "round_table",
            territory: "Camelot Valley"
        ),
        
        Team(
            id: UUID(uuidString: "J821E1F8-C36C-495A-93FC-0C247A3E6E5F")!,
            name: "Wizard's Tower Properties",
            leaderId: UUID(uuidString: "K821E1F8-C36C-495A-93FC-0C247A3E6E5F")!,
            memberIds: [
                UUID(uuidString: "K821E1F8-C36C-495A-93FC-0C247A3E6E5F")!,
                UUID(uuidString: "L821E1F8-C36C-495A-93FC-0C247A3E6E5F")!
            ],
            createdAt: Date().addingTimeInterval(-15 * 24 * 60 * 60), // 15 days ago
            motto: "Magical homes for magical folk",
            emblemImageName: "wizard_tower",
            territory: "Enchanted Forest"
        )
    ]
}

extension TeamMember {
    /// Sample team members for testing and preview
    static var samples: [TeamMember] = [
        // Dragon Slayers Realty members
        TeamMember(
            id: UUID(uuidString: "F621E1F8-C36C-495A-93FC-0C247A3E6E5F")!,
            userId: UUID(uuidString: "F621E1F8-C36C-495A-93FC-0C247A3E6E5F")!,
            name: "Sir Lancelot",
            rank: "Grand Knight",
            joinedAt: Date().addingTimeInterval(-90 * 24 * 60 * 60), // 90 days ago
            specialization: "Castle Sales",
            performance: TeamPerformance(
                propertiesSold: 12,
                goldEarned: 2400,
                questsCompleted: 18,
                satisfactionRating: 4.8,
                newClients: 7,
                achievements: ["Dragon Slayer", "Royal Appointment"]
            ),
            isLeader: true,
            profileImageName: "knight_profile",
            bio: "A valiant knight with a keen eye for prime castle real estate."
        ),
        
        TeamMember(
            id: UUID(uuidString: "G621E1F8-C36C-495A-93FC-0C247A3E6E5F")!,
            userId: UUID(uuidString: "G621E1F8-C36C-495A-93FC-0C247A3E6E5F")!,
            name: "Lady Guinevere",
            rank: "Noble Agent",
            joinedAt: Date().addingTimeInterval(-85 * 24 * 60 * 60), // 85 days ago
            specialization: "Manor Estates",
            performance: TeamPerformance(
                propertiesSold: 9,
                goldEarned: 1800,
                questsCompleted: 15,
                satisfactionRating: 4.9,
                newClients: 5,
                achievements: ["Royal Favor"]
            ),
            isLeader: false,
            profileImageName: "lady_profile",
            bio: "Specializes in luxury manor estates for the discerning nobility."
        ),
        
        TeamMember(
            id: UUID(uuidString: "H621E1F8-C36C-495A-93FC-0C247A3E6E5F")!,
            userId: UUID(uuidString: "H621E1F8-C36C-495A-93FC-0C247A3E6E5F")!,
            name: "Squire Gawain",
            rank: "Apprentice",
            joinedAt: Date().addingTimeInterval(-30 * 24 * 60 * 60), // 30 days ago
            specialization: "Village Cottages",
            performance: TeamPerformance(
                propertiesSold: 3,
                goldEarned: 450,
                questsCompleted: 7,
                satisfactionRating: 4.2,
                newClients: 2,
                achievements: ["Quick Learner"]
            ),
            isLeader: false,
            profileImageName: "squire_profile",
            bio: "A promising young squire with a talent for finding cozy village properties."
        ),
        
        // Knights of the Round Estate members
        TeamMember(
            id: UUID(uuidString: "B721E1F8-C36C-495A-93FC-0C247A3E6E5F")!,
            userId: UUID(uuidString: "B721E1F8-C36C-495A-93FC-0C247A3E6E5F")!,
            name: "King Arthur",
            rank: "Sovereign Broker",
            joinedAt: Date().addingTimeInterval(-180 * 24 * 60 * 60), // 180 days ago
            specialization: "Royal Castles",
            performance: TeamPerformance(
                propertiesSold: 15,
                goldEarned: 3000,
                questsCompleted: 22,
                satisfactionRating: 5.0,
                newClients: 9,
                achievements: ["Excalibur Award", "Crown's Favor", "Legendary Negotiator"]
            ),
            isLeader: true,
            profileImageName: "king_profile",
            bio: "The once and future king of real estate, specializing in royal properties."
        )
    ]
}

// MARK: - Helper Extensions

extension Array where Element == TeamMember {
    /// Calculate the average performance of all team members
    var averagePerformance: Double {
        return TeamManager.calculateAveragePerformance(for: self)
    }
    
    /// Find the top performer in the team
    var topPerformer: TeamMember? {
        return TeamManager.findTopPerformer(in: self)
    }
    
    /// Calculate team level based on combined performance
    var teamLevel: Int {
        return TeamManager.calculateTeamLevel(for: self)
    }
    
    /// Get team title based on team level
    var teamTitle: String {
        return TeamManager.teamTitle(for: teamLevel)
    }
} 