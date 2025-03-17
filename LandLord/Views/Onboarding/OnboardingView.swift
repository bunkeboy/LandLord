//
//  OnboardingView.swift
//  LandLord
//
//  Created for bunkeboyLandLord2
//  Medieval 8-bit themed real estate app
//

import SwiftUI

struct OnboardingView: View {
    // Track onboarding completion
    @AppStorage("onboardingComplete") private var onboardingComplete = false
    
    // Current page index
    @State private var currentPage = 0
    
    // Annual goal values
    @State private var gciTarget: Double = 100000
    @State private var volumeTarget: Double = 1000000
    @State private var transactionTarget: Double = 10
    
    // Medieval theme colors
    private let primaryColor = Color(red: 101/255, green: 67/255, blue: 33/255) // Brown
    private let goldColor = Color(red: 212/255, green: 175/255, blue: 55/255) // Gold
    private let backgroundColor = Color(red: 225/255, green: 193/255, blue: 110/255) // Parchment
    private let accentColor = Color(red: 75/255, green: 0/255, blue: 130/255) // Deep Purple
    
    var body: some View {
        ZStack {
            // Background
            backgroundColor.ignoresSafeArea()
            
            VStack {
                // Page indicator
                HStack {
                    ForEach(0..<3) { index in
                        Circle()
                            .fill(currentPage == index ? accentColor : Color.gray.opacity(0.5))
                            .frame(width: 10, height: 10)
                    }
                }
                .padding(.top, 20)
                
                // Page view
                TabView(selection: $currentPage) {
                    // Page 1: Welcome
                    welcomePage
                        .tag(0)
                    
                    // Page 2: Annual Goals
                    goalsPage
                        .tag(1)
                    
                    // Page 3: Confirmation
                    confirmationPage
                        .tag(2)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .animation(.easeInOut, value: currentPage)
                
                // Navigation buttons
                HStack {
                    // Back button (hidden on first page)
                    if currentPage > 0 {
                        Button(action: {
                            currentPage -= 1
                        }) {
                            HStack {
                                Image(systemName: "arrow.left")
                                Text("Back")
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(accentColor)
                            )
                        }
                    }
                    
                    Spacer()
                    
                    // Next button (hidden on last page)
                    if currentPage < 2 {
                        Button(action: {
                            currentPage += 1
                        }) {
                            HStack {
                                Text("Next")
                                Image(systemName: "arrow.right")
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(accentColor)
                            )
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
            }
            .padding()
        }
    }
    
    // MARK: - Page Views
    
    // Welcome page
    private var welcomePage: some View {
        VStack(spacing: 30) {
            // Medieval header
            Text("Welcome, Noble Agent")
                .font(.custom("Papyrus", size: 32, relativeTo: .title))
                .foregroundColor(primaryColor)
                .multilineTextAlignment(.center)
            
            // Crown icon
            Image(systemName: "crown.fill")
                .font(.system(size: 60))
                .foregroundColor(goldColor)
                .padding()
                .background(
                    Circle()
                        .fill(Color.white.opacity(0.7))
                        .shadow(radius: 5)
                )
            
            // App explanation
            VStack(alignment: .leading, spacing: 20) {
                explanationRow(icon: "house.fill", text: "Manage thy real estate kingdom with medieval flair")
                explanationRow(icon: "scroll.fill", text: "Complete daily quests to earn gold and glory")
                explanationRow(icon: "chart.line.uptrend.xyaxis", text: "Track thy progress and rise through the ranks")
                explanationRow(icon: "person.2.fill", text: "Compete with fellow knights in thy realm")
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white.opacity(0.7))
                    .shadow(radius: 3)
            )
            
            Spacer()
            
            // Decorative elements
            HStack(spacing: 40) {
                Image(systemName: "shield.lefthalf.filled")
                    .font(.system(size: 30))
                    .foregroundColor(accentColor)
                
                Image(systemName: "flag.fill")
                    .font(.system(size: 30))
                    .foregroundColor(primaryColor)
                
                Image(systemName: "shield.righthalf.filled")
                    .font(.system(size: 30))
                    .foregroundColor(accentColor)
            }
        }
        .padding()
    }
    
    // Goals page
    private var goalsPage: some View {
        VStack(spacing: 25) {
            // Medieval header
            Text("Set Thy Annual Conquest Goals")
                .font(.custom("Papyrus", size: 28, relativeTo: .title))
                .foregroundColor(primaryColor)
                .multilineTextAlignment(.center)
            
            // Scroll icon
            Image(systemName: "scroll.fill")
                .font(.system(size: 50))
                .foregroundColor(primaryColor)
                .padding()
                .background(
                    Circle()
                        .fill(Color.white.opacity(0.7))
                        .shadow(radius: 5)
                )
            
            // GCI slider
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Royal Treasury Target (GCI)")
                        .font(.headline)
                        .foregroundColor(primaryColor)
                    
                    Spacer()
                    
                    Text("$\(Int(gciTarget))")
                        .font(.headline)
                        .foregroundColor(goldColor)
                }
                
                Slider(value: $gciTarget, in: 50000...500000, step: 10000)
                    .accentColor(goldColor)
                
                Text("How much gold shall fill thy coffers?")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white.opacity(0.7))
                    .shadow(radius: 3)
            )
            
            // Volume slider
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Kingdom Expansion (Volume)")
                        .font(.headline)
                        .foregroundColor(primaryColor)
                    
                    Spacer()
                    
                    Text("$\(Int(volumeTarget))")
                        .font(.headline)
                        .foregroundColor(goldColor)
                }
                
                Slider(value: $volumeTarget, in: 500000...5000000, step: 100000)
                    .accentColor(goldColor)
                
                Text("How vast shall thy real estate empire grow?")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white.opacity(0.7))
                    .shadow(radius: 3)
            )
            
            // Transaction slider
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Battle Victories (Transactions)")
                        .font(.headline)
                        .foregroundColor(primaryColor)
                    
                    Spacer()
                    
                    Text("\(Int(transactionTarget))")
                        .font(.headline)
                        .foregroundColor(goldColor)
                }
                
                Slider(value: $transactionTarget, in: 1...50, step: 1)
                    .accentColor(goldColor)
                
                Text("How many victories shall thou claim?")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white.opacity(0.7))
                    .shadow(radius: 3)
            )
            
            Spacer()
            
            // Decorative elements
            HStack(spacing: 40) {
                Image(systemName: "dollarsign.circle.fill")
                    .font(.system(size: 30))
                    .foregroundColor(goldColor)
                
                Image(systemName: "house.fill")
                    .font(.system(size: 30))
                    .foregroundColor(primaryColor)
                
                Image(systemName: "checkmark.seal.fill")
                    .font(.system(size: 30))
                    .foregroundColor(goldColor)
            }
        }
        .padding()
    }
    
    // Confirmation page
    private var confirmationPage: some View {
        VStack(spacing: 30) {
            // Medieval header
            Text("Prepare for Thy Quest")
                .font(.custom("Papyrus", size: 32, relativeTo: .title))
                .foregroundColor(primaryColor)
                .multilineTextAlignment(.center)
            
            // Shield icon
            Image(systemName: "shield.fill")
                .font(.system(size: 60))
                .foregroundColor(accentColor)
                .padding()
                .background(
                    Circle()
                        .fill(Color.white.opacity(0.7))
                        .shadow(radius: 5)
                )
            
            // Summary
            VStack(alignment: .leading, spacing: 15) {
                Text("Thy Royal Proclamation:")
                    .font(.headline)
                    .foregroundColor(primaryColor)
                
                Divider()
                    .background(primaryColor)
                
                Text("I hereby declare my intent to conquer the real estate realm with the following goals:")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 5)
                
                HStack {
                    Text("Royal Treasury:")
                        .font(.subheadline)
                        .foregroundColor(primaryColor)
                    
                    Spacer()
                    
                    Text("$\(Int(gciTarget))")
                        .font(.subheadline)
                        .foregroundColor(goldColor)
                }
                
                HStack {
                    Text("Kingdom Expansion:")
                        .font(.subheadline)
                        .foregroundColor(primaryColor)
                    
                    Spacer()
                    
                    Text("$\(Int(volumeTarget))")
                        .font(.subheadline)
                        .foregroundColor(goldColor)
                }
                
                HStack {
                    Text("Battle Victories:")
                        .font(.subheadline)
                        .foregroundColor(primaryColor)
                    
                    Spacer()
                    
                    Text("\(Int(transactionTarget))")
                        .font(.subheadline)
                        .foregroundColor(goldColor)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white.opacity(0.7))
                    .shadow(radius: 3)
            )
            
            Spacer()
            
            // Begin Quest button
            Button(action: {
                // Save goals (would be implemented with Firebase later)
                saveGoals()
                
                // Mark onboarding as complete
                onboardingComplete = true
            }) {
                HStack {
                    Image(systemName: "flag.fill")
                    Text("Begin Thy Quest")
                    Image(systemName: "flag.fill")
                }
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(accentColor)
                        .shadow(radius: 3)
                )
            }
            .padding(.horizontal)
            
            // Decorative elements
            HStack(spacing: 40) {
                Image(systemName: "crown.fill")
                    .font(.system(size: 30))
                    .foregroundColor(goldColor)
                
                Image(systemName: "scroll.fill")
                    .font(.system(size: 30))
                    .foregroundColor(primaryColor)
                
                Image(systemName: "crown.fill")
                    .font(.system(size: 30))
                    .foregroundColor(goldColor)
            }
        }
        .padding()
    }
    
    // MARK: - Helper Views
    
    // Explanation row with icon and text
    private func explanationRow(icon: String, text: String) -> some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(accentColor)
                .frame(width: 30)
            
            Text(text)
                .font(.body)
                .foregroundColor(primaryColor)
        }
    }
    
    // MARK: - Helper Methods
    
    // Save goals (placeholder for now)
    private func saveGoals() {
        // In a real app, this would save to Firebase
        print("Annual goals set: GCI: $\(Int(gciTarget)), Volume: $\(Int(volumeTarget)), Transactions: \(Int(transactionTarget))")
        
        // This would create an AnnualGoal object and save it
        let userId = "user123" // Would get from AuthViewModel
        let goal = AnnualGoal(
            userId: userId,
            gciTarget: gciTarget,
            volumeTarget: volumeTarget,
            transactionTarget: Int(transactionTarget),
            year: Calendar.current.component(.year, from: Date())
        )
        
        // Would call FirebaseService.saveAnnualGoal(goal)
    }
}

#Preview {
    OnboardingView()
} 