//
//  LoginView.swift
//  LandLord
//
//  Created for bunkeboyLandLord2
//  Medieval 8-bit themed real estate app
//

import SwiftUI

struct LoginView: View {
    // Store authentication state in AppStorage
    @AppStorage("isAuthenticated") private var isAuthenticated = false
    
    // App benefits to display
    private let appBenefits = [
        "Conquer thy real estate quests with medieval flair",
        "Earn gold and rise through the ranks of nobility",
        "Track thy kingdom's expansion with royal metrics"
    ]
    
    // Colors for 8-bit pixel art styling
    private let primaryColor = Color(red: 101/255, green: 67/255, blue: 33/255) // Brown
    private let accentColor = Color(red: 155/255, green: 118/255, blue: 83/255) // Light brown
    private let goldColor = Color(red: 212/255, green: 175/255, blue: 55/255) // Gold
    private let backgroundColor = Color(red: 225/255, green: 193/255, blue: 110/255) // Parchment
    
    var body: some View {
        ZStack {
            // Background
            backgroundColor.ignoresSafeArea()
            
            VStack(spacing: 30) {
                // Medieval-themed header
                VStack(spacing: 10) {
                    Text("LandLord")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(primaryColor)
                        .padding(.top, 60)
                    
                    // Crown icon
                    Image(systemName: "crown.fill")
                        .font(.system(size: 40))
                        .foregroundColor(goldColor)
                    
                    Text("Thy Real Estate Kingdom")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(primaryColor)
                        .padding(.bottom, 20)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(primaryColor, lineWidth: 4)
                        .background(accentColor.opacity(0.3))
                )
                
                // Benefits section with pixel art styling
                VStack(alignment: .leading, spacing: 20) {
                    Text("Royal Proclamation:")
                        .font(.headline)
                        .foregroundColor(primaryColor)
                    
                    ForEach(appBenefits, id: \.self) { benefit in
                        HStack(spacing: 15) {
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundColor(goldColor)
                            
                            Text(benefit)
                                .font(.system(size: 16))
                                .foregroundColor(primaryColor)
                        }
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(primaryColor, lineWidth: 2)
                        .background(Color.white.opacity(0.7))
                )
                
                Spacer()
                
                // Google sign-in button (UI only)
                Button(action: signIn) {
                    HStack {
                        Image(systemName: "g.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                        
                        Text("Sign in with Google")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.blue)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                    )
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 40)
                
                // Pixel art footer
                HStack(spacing: 20) {
                    pixelArtIcon("shield.lefthalf.filled")
                    pixelArtIcon("house.fill")
                    pixelArtIcon("crown.fill")
                    pixelArtIcon("flag.fill")
                    pixelArtIcon("shield.righthalf.filled")
                }
                .padding(.bottom, 20)
            }
            .padding()
        }
    }
    
    // Sign in function that updates isAuthenticated
    private func signIn() {
        // For now, just toggle isAuthenticated to true
        isAuthenticated = true
        
        // Play medieval sound effect (placeholder)
        // playSound("victory")
        
        print("User signed in!")
    }
    
    // Helper function to create pixel art style icons
    private func pixelArtIcon(_ systemName: String) -> some View {
        Image(systemName: systemName)
            .font(.system(size: 24))
            .foregroundColor(primaryColor)
            .padding(8)
            .background(
                Rectangle()
                    .fill(accentColor.opacity(0.3))
                    .border(primaryColor, width: 2)
            )
    }
}

#Preview {
    LoginView()
} 