//
//  MedievalComponents.swift
//  LandLord
//
//  Created for bunkeboyLandLord2
//  Medieval 8-bit themed real estate app
//

import SwiftUI
import Foundation

// MARK: - Medieval Button

/// A medieval-styled button with gold border and parchment background
struct MedievalButton: View {
    // Button text
    let title: String
    
    // Button action
    let action: () -> Void
    
    // Optional icon name
    var iconName: String?
    
    // Button style
    var style: ButtonStyle = .primary
    
    // Button size
    var size: ButtonSize = .medium
    
    // Button styles
    enum ButtonStyle {
        case primary    // Gold with brown text
        case secondary  // Brown with gold text
        case danger     // Red with white text
        case ghost      // Transparent with brown border
    }
    
    // Button sizes
    enum ButtonSize {
        case small
        case medium
        case large
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                // Leading icon if provided
                if let iconName = iconName {
                    Image(systemName: iconName)
                        .font(iconFont)
                }
                
                // Button text
                Text(title)
                    .font(textFont)
            }
            .padding(.vertical, verticalPadding)
            .padding(.horizontal, horizontalPadding)
            .frame(maxWidth: size == .large ? .infinity : nil)
            .foregroundColor(foregroundColor)
            .background(
                RoundedRectangle(cornerRadius: ThemeManager.cornerRadius)
                    .fill(backgroundColor)
            )
            .overlay(
                RoundedRectangle(cornerRadius: ThemeManager.cornerRadius)
                    .strokeBorder(borderColor, lineWidth: borderWidth)
            )
            .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 2)
        }
    }
    
    // Computed properties for styling
    
    private var backgroundColor: Color {
        switch style {
        case .primary:
            return ThemeManager.accentColor
        case .secondary:
            return ThemeManager.primaryColor
        case .danger:
            return Color.bloodRed
        case .ghost:
            return Color.clear
        }
    }
    
    private var foregroundColor: Color {
        switch style {
        case .primary:
            return .white
        case .secondary:
            return ThemeManager.accentColor
        case .danger:
            return .white
        case .ghost:
            return ThemeManager.primaryColor
        }
    }
    
    private var borderColor: Color {
        switch style {
        case .primary:
            return ThemeManager.accentColor.opacity(0.7)
        case .secondary:
            return ThemeManager.accentColor
        case .danger:
            return Color.bloodRed.opacity(0.7)
        case .ghost:
            return ThemeManager.primaryColor
        }
    }
    
    private var borderWidth: CGFloat {
        style == .ghost ? 2 : 1
    }
    
    private var textFont: Font {
        switch size {
        case .small:
            return .system(size: 14, weight: .semibold)
        case .medium:
            return .system(size: 16, weight: .semibold)
        case .large:
            return .system(size: 18, weight: .semibold)
        }
    }
    
    private var iconFont: Font {
        switch size {
        case .small:
            return .system(size: 12)
        case .medium:
            return .system(size: 14)
        case .large:
            return .system(size: 16)
        }
    }
    
    private var verticalPadding: CGFloat {
        switch size {
        case .small:
            return 6
        case .medium:
            return 10
        case .large:
            return 14
        }
    }
    
    private var horizontalPadding: CGFloat {
        switch size {
        case .small:
            return 12
        case .medium:
            return 16
        case .large:
            return 20
        }
    }
}

// MARK: - Quest Card

/// A card displaying quest information with medieval styling
struct QuestCard: View {
    // Quest data
    let title: String
    let description: String
    let goldReward: Int
    let experienceReward: Int
    let questType: QuestType
    let isCompleted: Bool
    
    // Optional action when card is tapped
    var onTap: (() -> Void)?
    
    // Optional action when complete button is tapped
    var onComplete: (() -> Void)?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Title and type
            HStack {
                // Quest type icon
                Image(systemName: questTypeIcon)
                    .font(.system(size: 18))
                    .foregroundColor(questTypeColor)
                    .frame(width: 24, height: 24)
                    .background(
                        Circle()
                            .fill(questTypeColor.opacity(0.2))
                    )
                
                // Quest title
                Text(title)
                    .font(.headline)
                    .foregroundColor(isCompleted ? Color.gray : ThemeManager.primaryColor)
                    .strikethrough(isCompleted)
                
                Spacer()
                
                // Completion status
                if isCompleted {
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundColor(.green)
                        .font(.system(size: 18))
                }
            }
            
            // Description
            Text(description)
                .font(.subheadline)
                .foregroundColor(isCompleted ? Color.gray : ThemeManager.textSecondary)
                .strikethrough(isCompleted)
                .lineLimit(2)
            
            Divider()
                .background(ThemeManager.primaryColor.opacity(0.3))
            
            // Rewards
            HStack {
                // Gold reward
                GoldBadge(amount: goldReward)
                
                Spacer()
                
                // XP reward
                HStack(spacing: 4) {
                    Text("+\(experienceReward) XP")
                        .font(.caption)
                        .foregroundColor(ThemeManager.secondaryColor)
                    
                    Image(systemName: "star.fill")
                        .font(.system(size: 12))
                        .foregroundColor(ThemeManager.secondaryColor)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .fill(ThemeManager.secondaryColor.opacity(0.1))
                )
                
                // Complete button (if not completed)
                if !isCompleted && onComplete != nil {
                    MedievalButton(
                        title: "Complete",
                        action: { onComplete?() },
                        iconName: "checkmark",
                        style: .primary,
                        size: .small
                    )
                }
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: ThemeManager.cornerRadius)
                .fill(Color.white.opacity(0.7))
                .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
        )
        .opacity(isCompleted ? 0.8 : 1.0)
        .onTapGesture {
            onTap?()
        }
    }
    
    // Quest type icon
    private var questTypeIcon: String {
        switch questType {
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
        case .property:
            return "house.fill"
        }
    }
    
    // Quest type color
    private var questTypeColor: Color {
        switch questType {
        case .listing:
            return .blue
        case .showing:
            return .green
        case .offer:
            return .orange
        case .closing:
            return .purple
        case .prospecting:
            return .red
        case .training:
            return ThemeManager.secondaryColor
        case .marketing:
            return .pink
        case .property:
            return .brown
        }
    }
}

// MARK: - Gold Badge

/// A badge displaying gold amount with coin icon
struct GoldBadge: View {
    // Gold amount
    let amount: Int
    
    // Badge size
    var size: BadgeSize = .medium
    
    // Badge sizes
    enum BadgeSize {
        case small
        case medium
        case large
    }
    
    var body: some View {
        HStack(spacing: 4) {
            // Coin icon
            Image(systemName: "coins.fill")
                .font(iconFont)
                .foregroundColor(ThemeManager.accentColor)
            
            // Gold amount
            Text("\(amount)")
                .font(textFont)
                .foregroundColor(ThemeManager.accentColor)
        }
        .padding(.horizontal, horizontalPadding)
        .padding(.vertical, verticalPadding)
        .background(
            RoundedRectangle(cornerRadius: 6)
                .fill(ThemeManager.accentColor.opacity(0.1))
        )
    }
    
    // Computed properties for sizing
    
    private var textFont: Font {
        switch size {
        case .small:
            return .caption
        case .medium:
            return .caption
        case .large:
            return .subheadline
        }
    }
    
    private var iconFont: Font {
        switch size {
        case .small:
            return .system(size: 10)
        case .medium:
            return .system(size: 12)
        case .large:
            return .system(size: 14)
        }
    }
    
    private var horizontalPadding: CGFloat {
        switch size {
        case .small:
            return 6
        case .medium:
            return 8
        case .large:
            return 10
        }
    }
    
    private var verticalPadding: CGFloat {
        switch size {
        case .small:
            return 2
        case .medium:
            return 4
        case .large:
            return 6
        }
    }
}

// MARK: - Shield Counter

/// A counter displaying shields/hearts with medieval styling
struct ShieldCounter: View {
    // Current count
    let current: Int
    
    // Maximum count
    let maximum: Int
    
    // Counter type
    var type: CounterType = .shield
    
    // Counter types
    enum CounterType {
        case shield
        case heart
    }
    
    var body: some View {
        HStack(spacing: 4) {
            // Icons
            HStack(spacing: 2) {
                ForEach(0..<maximum, id: \.self) { index in
                    Image(systemName: iconName(for: index))
                        .foregroundColor(iconColor(for: index))
                        .font(.system(size: 16))
                }
            }
            
            // Count text
            Text("\(current)/\(maximum)")
                .font(.caption)
                .foregroundColor(ThemeManager.primaryColor)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white.opacity(0.7))
                .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
        )
    }
    
    // Icon name based on type and filled status
    private func iconName(for index: Int) -> String {
        let isFilled = index < current
        
        switch type {
        case .shield:
            return isFilled ? "shield.fill" : "shield"
        case .heart:
            return isFilled ? "heart.fill" : "heart"
        }
    }
    
    // Icon color based on type and filled status
    private func iconColor(for index: Int) -> Color {
        let isFilled = index < current
        
        switch type {
        case .shield:
            return isFilled ? .blue : Color.gray.opacity(0.5)
        case .heart:
            return isFilled ? .red : Color.gray.opacity(0.5)
        }
    }
}

// MARK: - Progress Bar

/// A medieval-styled progress bar for level progress
struct ProgressBar: View {
    // Current progress (0-100)
    let progress: Double
    
    // Optional label
    var label: String?
    
    // Optional value text
    var valueText: String?
    
    // Bar height
    var height: CGFloat = 20
    
    // Bar color
    var color: Color = Color.forestGreen
    
    // Show percentage text
    var showPercentage: Bool = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            // Label if provided
            if let label = label {
                Text(label)
                    .font(.caption)
                    .foregroundColor(ThemeManager.primaryColor)
            }
            
            ZStack(alignment: .leading) {
                // Background
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: height)
                    .cornerRadius(height / 2)
                
                // Progress
                Rectangle()
                    .fill(color)
                    .frame(width: calculateWidth(), height: height)
                    .cornerRadius(height / 2)
                
                // Border
                Rectangle()
                    .strokeBorder(ThemeManager.primaryColor.opacity(0.3), lineWidth: 1)
                    .frame(height: height)
                    .cornerRadius(height / 2)
                
                // Percentage text
                if showPercentage {
                    Text("\(Int(progress))%")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .frame(width: calculateWidth(), alignment: .trailing)
                        .opacity(progress > 15 ? 1 : 0) // Only show if bar is wide enough
                }
                
                // Value text if provided
                if let valueText = valueText {
                    Text(valueText)
                        .font(.caption)
                        .foregroundColor(ThemeManager.primaryColor)
                        .padding(.horizontal, 8)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
        }
    }
    
    // Calculate width based on progress
    private func calculateWidth() -> CGFloat {
        // Get the geometry proxy's width and calculate progress width
        let screenWidth = UIScreen.main.bounds.width - 40 // Approximate padding
        return screenWidth * CGFloat(min(max(progress, 0), 100)) / 100.0
    }
}

// MARK: - Preview Providers

struct MedievalButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            MedievalButton(
                title: "Primary Button",
                action: {},
                iconName: "crown.fill",
                style: .primary
            )
            
            MedievalButton(
                title: "Secondary Button",
                action: {},
                iconName: "shield.fill",
                style: .secondary
            )
            
            MedievalButton(
                title: "Danger Button",
                action: {},
                iconName: "exclamationmark.triangle.fill",
                style: .danger
            )
            
            MedievalButton(
                title: "Ghost Button",
                action: {},
                iconName: "scroll.fill",
                style: .ghost
            )
            
            MedievalButton(
                title: "Large Button",
                action: {},
                iconName: "flag.fill",
                style: .primary,
                size: .large
            )
        }
        .padding()
        .background(ThemeManager.backgroundPrimary)
        .previewLayout(.sizeThatFits)
    }
}

struct QuestCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            QuestCard(
                title: "List a New Property",
                description: "Claim new land for thy kingdom by listing a property for sale.",
                goldReward: 50,
                experienceReward: 25,
                questType: .property,
                isCompleted: false,
                onTap: {},
                onComplete: {}
            )
            
            QuestCard(
                title: "Host an Open House",
                description: "Open thy castle gates and welcome potential buyers to view the property.",
                goldReward: 30,
                experienceReward: 15,
                questType: .daily,
                isCompleted: true,
                onTap: {}
            )
        }
        .padding()
        .background(ThemeManager.backgroundPrimary)
        .previewLayout(.sizeThatFits)
    }
}

struct GoldBadge_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 20) {
            GoldBadge(amount: 50, size: .small)
            GoldBadge(amount: 100, size: .medium)
            GoldBadge(amount: 1000, size: .large)
        }
        .padding()
        .background(ThemeManager.backgroundPrimary)
        .previewLayout(.sizeThatFits)
    }
}

struct ShieldCounter_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            ShieldCounter(current: 2, maximum: 3, type: .shield)
            ShieldCounter(current: 4, maximum: 5, type: .heart)
        }
        .padding()
        .background(ThemeManager.backgroundPrimary)
        .previewLayout(.sizeThatFits)
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            ProgressBar(
                progress: 35,
                label: "Level Progress",
                valueText: "35/100 XP"
            )
            
            ProgressBar(
                progress: 75,
                label: "Quest Completion",
                color: ThemeManager.accentColor
            )
            
            ProgressBar(
                progress: 100,
                color: .blue,
                showPercentage: false
            )
        }
        .padding()
        .background(ThemeManager.backgroundPrimary)
        .previewLayout(.sizeThatFits)
    }
} 