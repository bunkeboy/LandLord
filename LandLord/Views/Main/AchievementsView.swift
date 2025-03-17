//
//  AchievementsView.swift
//  LandLord
//
//  Created for bunkeboyLandLord2
//  Medieval 8-bit themed real estate app
//

import SwiftUI

/// View for displaying user achievements and badges
struct AchievementsView: View {
    // MARK: - Properties
    
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedCategory: AchievementCategory = .all
    @State private var achievements: [Achievement] = []
    @State private var isLoading = true
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 0) {
            // Header with category selector
            categoryPicker
                .padding(.top)
            
            // Achievement list
            if isLoading {
                loadingView
            } else if filteredAchievements.isEmpty {
                emptyStateView
            } else {
                achievementsList
            }
        }
        .navigationTitle("Royal Achievements")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Done")
                        .foregroundColor(Color("medievalGold"))
                }
            }
        }
        .onAppear {
            loadAchievements()
        }
        .background(Color("medievalBrown").opacity(0.1).ignoresSafeArea())
    }
    
    // MARK: - Views
    
    /// Category picker at the top
    private var categoryPicker: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(AchievementCategory.allCases, id: \.self) { category in
                    categoryButton(for: category)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
        .background(Color("medievalBrown").opacity(0.2))
    }
    
    /// Button for each category
    private func categoryButton(for category: AchievementCategory) -> some View {
        Button(action: {
            withAnimation {
                selectedCategory = category
            }
        }) {
            Text(category.displayName)
                .font(.system(size: 14, weight: .medium))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    selectedCategory == category ?
                    Color("medievalGold") :
                    Color("medievalBrown").opacity(0.3)
                )
                .foregroundColor(
                    selectedCategory == category ?
                    Color("medievalBrown") :
                    Color("medievalGold")
                )
                .cornerRadius(20)
        }
    }
    
    /// Loading state view
    private var loadingView: some View {
        VStack {
            Spacer()
            ProgressView()
                .scaleEffect(1.5)
                .progressViewStyle(CircularProgressViewStyle(tint: Color("medievalGold")))
            Text("Consulting the Royal Archives...")
                .font(.headline)
                .foregroundColor(Color("medievalBrown"))
                .padding(.top)
            Spacer()
        }
    }
    
    /// Empty state view when no achievements match the filter
    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Image(systemName: "trophy")
                .font(.system(size: 60))
                .foregroundColor(Color("medievalGold").opacity(0.5))
            
            Text("No Achievements Yet")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(Color("medievalBrown"))
            
            Text("Complete quests and tasks to earn royal achievements and badges for thy collection.")
                .multilineTextAlignment(.center)
                .foregroundColor(Color("medievalBrown").opacity(0.8))
                .padding(.horizontal, 40)
            
            Spacer()
        }
    }
    
    /// List of achievements
    private var achievementsList: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(filteredAchievements) { achievement in
                    AchievementRow(achievement: achievement)
                }
            }
            .padding()
        }
    }
    
    // MARK: - Helper Methods
    
    /// Load achievements from data source
    private func loadAchievements() {
        // Simulate loading from a data source
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // In a real app, this would fetch from a database
            // For now, we'll use sample data
            self.achievements = [
                Achievement(
                    id: UUID().uuidString,
                    userId: "user123",
                    type: .firstLogin,
                    earnedDate: Date().addingTimeInterval(-60*60*24*7), // 7 days ago
                    metadata: ["app_version": "1.0"]
                ),
                Achievement(
                    id: UUID().uuidString,
                    userId: "user123",
                    type: .firstQuest,
                    earnedDate: Date().addingTimeInterval(-60*60*24*5), // 5 days ago
                    metadata: ["quest_id": "quest123"]
                ),
                Achievement(
                    id: UUID().uuidString,
                    userId: "user123",
                    type: .weekStreak,
                    earnedDate: Date().addingTimeInterval(-60*60*24*2), // 2 days ago
                    metadata: ["streak_days": "7"],
                    isNew: true
                )
            ]
            
            self.isLoading = false
        }
    }
    
    /// Filter achievements based on selected category
    private var filteredAchievements: [Achievement] {
        if selectedCategory == .all {
            return achievements
        } else {
            return achievements.filter { $0.type.category == selectedCategory }
        }
    }
}

// MARK: - Supporting Views

/// Row for displaying a single achievement
struct AchievementRow: View {
    let achievement: Achievement
    
    var body: some View {
        HStack(spacing: 16) {
            // Badge image
            ZStack {
                Circle()
                    .fill(Color("medievalGold").opacity(0.2))
                    .frame(width: 60, height: 60)
                
                Image(systemName: badgeIconName)
                    .font(.system(size: 30))
                    .foregroundColor(Color("medievalGold"))
            }
            
            // Achievement details
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(achievement.badge.name)
                        .font(.headline)
                        .foregroundColor(Color("medievalBrown"))
                    
                    if achievement.isNew {
                        Text("NEW")
                            .font(.system(size: 10, weight: .bold))
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(4)
                    }
                }
                
                Text(achievement.badge.description)
                    .font(.subheadline)
                    .foregroundColor(Color("medievalBrown").opacity(0.8))
                    .lineLimit(2)
                
                Text("Earned: \(formattedDate)")
                    .font(.caption)
                    .foregroundColor(Color("medievalBrown").opacity(0.6))
            }
            
            Spacer()
            
            // Rarity indicator
            rarityBadge
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
        )
    }
    
    // MARK: - Helper Properties
    
    /// Icon name for the badge
    private var badgeIconName: String {
        switch achievement.type.category {
        case .onboarding:
            return "person.fill"
        case .quests:
            return "checkmark.seal.fill"
        case .listings:
            return "house.fill"
        case .transactions:
            return "dollarsign.circle.fill"
        case .gold:
            return "coins.fill"
        case .streaks:
            return "calendar.badge.clock"
        case .levels:
            return "crown.fill"
        case .all:
            return "trophy.fill"
        }
    }
    
    /// Formatted date string
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: achievement.earnedDate)
    }
    
    /// Badge showing rarity level
    private var rarityBadge: some View {
        Text(achievement.badge.rarity.rawValue)
            .font(.system(size: 10, weight: .bold))
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(rarityColor)
            .foregroundColor(.white)
            .cornerRadius(8)
    }
    
    /// Color based on rarity
    private var rarityColor: Color {
        switch achievement.badge.rarity {
        case .common:
            return Color.gray
        case .uncommon:
            return Color.green
        case .rare:
            return Color.blue
        case .epic:
            return Color.purple
        case .legendary:
            return Color.orange
        }
    }
}

// MARK: - Preview

struct AchievementsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AchievementsView()
        }
    }
} 