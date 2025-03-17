//
//  ThemeManager.swift
//  LandLord
//
//  Created for bunkeboyLandLord2
//  Medieval 8-bit themed real estate app
//

import SwiftUI

/// Manages theme-related properties and methods for consistent styling across the app
struct ThemeManager {
    
    // MARK: - Colors
    
    /// Primary color - Brown
    static var primaryColor: Color {
        return Color("medievalBrown")
    }
    
    /// Secondary color - Deep Purple
    static var secondaryColor: Color {
        return Color("royalPurple")
    }
    
    /// Accent color - Gold
    static var accentColor: Color {
        return Color("medievalGold")
    }
    
    /// Primary background color - Parchment
    static var backgroundPrimary: Color {
        return Color.parchment
    }
    
    /// Secondary background color - Light Parchment
    static var backgroundSecondary: Color {
        return Color.lightParchment
    }
    
    /// Text primary color - Dark Brown
    static var textPrimary: Color {
        return Color.darkBrown
    }
    
    /// Text secondary color - Medium Brown
    static var textSecondary: Color {
        return Color.mediumBrown
    }
    
    // MARK: - Fonts
    
    /// Title font - Large medieval style
    static func titleFont(size: CGFloat = 32) -> Font {
        return Font.medievalTitle(size: size)
    }
    
    /// Body font - Regular text
    static func bodyFont(size: CGFloat = 16) -> Font {
        return Font.medievalBody(size: size)
    }
    
    /// Accent font - For emphasis
    static func accentFont(size: CGFloat = 18) -> Font {
        return Font.medievalAccent(size: size)
    }
    
    /// Caption font - Small text
    static func captionFont(size: CGFloat = 12) -> Font {
        return Font.medievalCaption(size: size)
    }
    
    // MARK: - Sizes
    
    /// Standard padding for containers
    static let standardPadding: CGFloat = 16
    
    /// Small padding for tight spaces
    static let smallPadding: CGFloat = 8
    
    /// Large padding for emphasis
    static let largePadding: CGFloat = 24
    
    /// Standard corner radius
    static let cornerRadius: CGFloat = 12
    
    /// Small corner radius
    static let smallCornerRadius: CGFloat = 6
    
    /// Standard icon size
    static let iconSize: CGFloat = 24
    
    /// Large icon size
    static let largeIconSize: CGFloat = 40
    
    /// Small icon size
    static let smallIconSize: CGFloat = 16
    
    /// Standard button height
    static let buttonHeight: CGFloat = 50
    
    // MARK: - Assets
    
    /// Get a themed image asset by name
    /// - Parameter named: The name of the image asset
    /// - Returns: The Image view with the requested asset
    static func getThemeImage(named: String) -> Image {
        // In a real implementation, this would check for themed variants
        // For now, just return the system image if it exists, or a fallback
        return Image(systemName: named) 
    }
    
    // MARK: - UI Element Styling
    
    /// Style for primary buttons
    static func primaryButtonStyle<S: Shape>(_ shape: S = RoundedRectangle(cornerRadius: cornerRadius)) -> some ViewModifier {
        return ButtonStyleModifier(backgroundColor: secondaryColor, foregroundColor: .white, shape: shape)
    }
    
    /// Style for secondary buttons
    static func secondaryButtonStyle<S: Shape>(_ shape: S = RoundedRectangle(cornerRadius: cornerRadius)) -> some ViewModifier {
        return ButtonStyleModifier(backgroundColor: .white.opacity(0.7), foregroundColor: primaryColor, shape: shape)
    }
    
    /// Style for accent buttons
    static func accentButtonStyle<S: Shape>(_ shape: S = RoundedRectangle(cornerRadius: cornerRadius)) -> some ViewModifier {
        return ButtonStyleModifier(backgroundColor: accentColor, foregroundColor: .white, shape: shape)
    }
    
    /// Style for card containers
    static func cardStyle<S: Shape>(_ shape: S = RoundedRectangle(cornerRadius: cornerRadius)) -> some ViewModifier {
        return CardStyleModifier(backgroundColor: .white.opacity(0.7), shape: shape)
    }
}

// MARK: - Color Extensions

extension Color {
    // These colors are now defined in the asset catalog, so we don't need to redefine them
    // medievalBrown, royalPurple, medievalGold, stoneGray, forestGreen
    
    /// Dark brown color
    static var darkBrown: Color {
        return Color(red: 81/255, green: 47/255, blue: 13/255)
    }
    
    /// Medium brown color
    static var mediumBrown: Color {
        return Color(red: 121/255, green: 87/255, blue: 53/255)
    }
    
    /// Parchment color
    static var parchment: Color {
        return Color(red: 225/255, green: 193/255, blue: 110/255)
    }
    
    /// Light parchment color
    static var lightParchment: Color {
        return Color(red: 235/255, green: 213/255, blue: 150/255)
    }
    
    /// Blood red color
    static var bloodRed: Color {
        return Color(red: 139/255, green: 0/255, blue: 0/255)
    }
}

// MARK: - Font Extensions

extension Font {
    /// Medieval title font
    static func medievalTitle(size: CGFloat = 32) -> Font {
        // If custom fonts are added, use them here
        // For now, use system font with appropriate weight
        return .custom("Papyrus", size: size, relativeTo: .title)
    }
    
    /// Medieval body font
    static func medievalBody(size: CGFloat = 16) -> Font {
        // If custom fonts are added, use them here
        // For now, use system font with appropriate weight
        return .system(size: size, weight: .regular)
    }
    
    /// Medieval accent font
    static func medievalAccent(size: CGFloat = 18) -> Font {
        // If custom fonts are added, use them here
        // For now, use system font with appropriate weight
        return .system(size: size, weight: .semibold)
    }
    
    /// Medieval caption font
    static func medievalCaption(size: CGFloat = 12) -> Font {
        // If custom fonts are added, use them here
        // For now, use system font with appropriate weight
        return .system(size: size, weight: .light)
    }
}

// MARK: - View Modifiers

/// Button style modifier
struct ButtonStyleModifier<S: Shape>: ViewModifier {
    let backgroundColor: Color
    let foregroundColor: Color
    let shape: S
    
    func body(content: Content) -> some View {
        content
            .padding()
            .foregroundColor(foregroundColor)
            .background(
                shape
                    .fill(backgroundColor)
                    .shadow(radius: 2)
            )
    }
}

/// Card style modifier
struct CardStyleModifier<S: Shape>: ViewModifier {
    let backgroundColor: Color
    let shape: S
    
    func body(content: Content) -> some View {
        content
            .padding(ThemeManager.standardPadding)
            .background(
                shape
                    .fill(backgroundColor)
                    .shadow(radius: 3)
            )
    }
}

// MARK: - View Extensions

extension View {
    /// Apply primary button style
    func primaryButtonStyle() -> some View {
        self.modifier(ThemeManager.primaryButtonStyle())
    }
    
    /// Apply secondary button style
    func secondaryButtonStyle() -> some View {
        self.modifier(ThemeManager.secondaryButtonStyle())
    }
    
    /// Apply accent button style
    func accentButtonStyle() -> some View {
        self.modifier(ThemeManager.accentButtonStyle())
    }
    
    /// Apply card style
    func cardStyle() -> some View {
        self.modifier(ThemeManager.cardStyle())
    }
} 