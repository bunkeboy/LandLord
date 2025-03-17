//
//  TreasuryView.swift
//  LandLord
//
//  Created for bunkeboyLandLord2
//  Medieval 8-bit themed real estate app
//

import SwiftUI

struct TreasuryView: View {
    // Placeholder data
    @State private var totalGold: Int = 1250
    @State private var level: Int = 2
    @State private var currentXP: Int = 175
    @State private var xpForNextLevel: Int = 300
    @State private var rank: String = "Novice Squire"
    @State private var streak: Int = 4
    @State private var questsCompleted: Int = 23
    
    // Animation properties
    @State private var isGoldAnimating: Bool = false
    
    // Medieval theme colors
    private let primaryColor = Color(red: 101/255, green: 67/255, blue: 33/255) // Brown
    private let goldColor = Color(red: 212/255, green: 175/255, blue: 55/255) // Gold
    private let backgroundColor = Color(red: 225/255, green: 193/255, blue: 110/255) // Parchment
    private let progressColor = Color(red: 76/255, green: 187/255, blue: 23/255) // Green
    
    var body: some View {
        NavigationView {
            ScrollView {
                ZStack {
                    // Background
                    backgroundColor.ignoresSafeArea()
                    
                    VStack(spacing: 24) {
                        // Medieval header
                        Text("Royal Treasury")
                            .font(.custom("Papyrus", size: 36, relativeTo: .title))
                            .foregroundColor(primaryColor)
                            .padding(.top, 20)
                        
                        // Gold section
                        VStack(spacing: 10) {
                            Text("Thy Gold")
                                .font(.headline)
                                .foregroundColor(primaryColor)
                            
                            ZStack {
                                // Gold coin
                                Image(systemName: "circle.fill")
                                    .font(.system(size: 100))
                                    .foregroundColor(goldColor)
                                    .shadow(radius: 2)
                                    .scaleEffect(isGoldAnimating ? 1.1 : 1.0)
                                    .animation(
                                        Animation.easeInOut(duration: 1.0)
                                            .repeatForever(autoreverses: true),
                                        value: isGoldAnimating
                                    )
                                    .onAppear {
                                        isGoldAnimating = true
                                    }
                                
                                Text("$")
                                    .font(.system(size: 50, weight: .bold))
                                    .foregroundColor(.white)
                            }
                            
                            Text("\(totalGold)")
                                .font(.system(size: 40, weight: .bold))
                                .foregroundColor(goldColor)
                                .shadow(radius: 1)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white.opacity(0.7))
                                .shadow(radius: 3)
                        )
                        .padding(.horizontal)
                        
                        // Level progress section
                        VStack(spacing: 12) {
                            HStack {
                                Image(systemName: "person.fill")
                                    .foregroundColor(primaryColor)
                                
                                Text("\(rank) - Level \(level)")
                                    .font(.headline)
                                    .foregroundColor(primaryColor)
                            }
                            
                            // XP Progress bar
                            VStack(spacing: 4) {
                                GeometryReader { geometry in
                                    ZStack(alignment: .leading) {
                                        // Background
                                        Rectangle()
                                            .frame(width: geometry.size.width, height: 20)
                                            .opacity(0.3)
                                            .foregroundColor(.gray)
                                        
                                        // Progress
                                        Rectangle()
                                            .frame(width: min(CGFloat(currentXP) / CGFloat(xpForNextLevel) * geometry.size.width, geometry.size.width), height: 20)
                                            .foregroundColor(progressColor)
                                            .animation(.linear, value: currentXP)
                                    }
                                    .cornerRadius(10)
                                }
                                .frame(height: 20)
                                
                                HStack {
                                    Text("\(currentXP) / \(xpForNextLevel) XP")
                                        .font(.caption)
                                        .foregroundColor(primaryColor)
                                    
                                    Spacer()
                                    
                                    Text("\(Int(Double(currentXP) / Double(xpForNextLevel) * 100))% to Level \(level + 1)")
                                        .font(.caption)
                                        .foregroundColor(primaryColor)
                                }
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white.opacity(0.7))
                                .shadow(radius: 3)
                        )
                        .padding(.horizontal)
                        
                        // Rewards section
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Thy Achievements")
                                .font(.headline)
                                .foregroundColor(primaryColor)
                                .padding(.bottom, 4)
                            
                            // Streak
                            HStack {
                                Image(systemName: "flame.fill")
                                    .foregroundColor(.orange)
                                    .font(.system(size: 24))
                                
                                VStack(alignment: .leading) {
                                    Text("Daily Streak")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    
                                    Text("\(streak) Days")
                                        .font(.headline)
                                        .foregroundColor(primaryColor)
                                }
                                
                                Spacer()
                                
                                // Streak bonus
                                Text("+\(streak * 5) Gold/Day")
                                    .font(.caption)
                                    .padding(6)
                                    .background(
                                        RoundedRectangle(cornerRadius: 4)
                                            .fill(goldColor.opacity(0.2))
                                    )
                                    .foregroundColor(goldColor)
                            }
                            .padding(.vertical, 8)
                            
                            Divider()
                                .background(primaryColor.opacity(0.3))
                            
                            // Quests completed
                            HStack {
                                Image(systemName: "checkmark.seal.fill")
                                    .foregroundColor(.green)
                                    .font(.system(size: 24))
                                
                                VStack(alignment: .leading) {
                                    Text("Quests Completed")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    
                                    Text("\(questsCompleted)")
                                        .font(.headline)
                                        .foregroundColor(primaryColor)
                                }
                                
                                Spacer()
                                
                                // Quest milestone
                                Text("Next: 25")
                                    .font(.caption)
                                    .padding(6)
                                    .background(
                                        RoundedRectangle(cornerRadius: 4)
                                            .fill(Color.green.opacity(0.2))
                                    )
                                    .foregroundColor(.green)
                            }
                            .padding(.vertical, 8)
                            
                            Divider()
                                .background(primaryColor.opacity(0.3))
                            
                            // Current rank
                            HStack {
                                Image(systemName: "crown.fill")
                                    .foregroundColor(goldColor)
                                    .font(.system(size: 24))
                                
                                VStack(alignment: .leading) {
                                    Text("Current Rank")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    
                                    Text(rank)
                                        .font(.headline)
                                        .foregroundColor(primaryColor)
                                }
                                
                                Spacer()
                                
                                // Next rank
                                Text("Next: Knight")
                                    .font(.caption)
                                    .padding(6)
                                    .background(
                                        RoundedRectangle(cornerRadius: 4)
                                            .fill(goldColor.opacity(0.2))
                                    )
                                    .foregroundColor(goldColor)
                            }
                            .padding(.vertical, 8)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white.opacity(0.7))
                                .shadow(radius: 3)
                        )
                        .padding(.horizontal)
                        
                        // Recent transactions
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Recent Transactions")
                                .font(.headline)
                                .foregroundColor(primaryColor)
                            
                            ForEach(recentTransactions) { transaction in
                                HStack {
                                    Image(systemName: transaction.icon)
                                        .foregroundColor(transaction.amount > 0 ? .green : .red)
                                    
                                    Text(transaction.description)
                                        .font(.subheadline)
                                        .foregroundColor(primaryColor)
                                    
                                    Spacer()
                                    
                                    Text(transaction.amount > 0 ? "+\(transaction.amount)" : "\(transaction.amount)")
                                        .font(.subheadline)
                                        .foregroundColor(transaction.amount > 0 ? .green : .red)
                                }
                                .padding(.vertical, 4)
                                
                                if transaction.id != recentTransactions.last?.id {
                                    Divider()
                                        .background(primaryColor.opacity(0.3))
                                }
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white.opacity(0.7))
                                .shadow(radius: 3)
                        )
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                    }
                }
            }
            .navigationTitle("Treasury")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // Sample transaction data
    private var recentTransactions: [Transaction] = [
        Transaction(description: "Completed Quest: List Property", amount: 50, icon: "checkmark.circle.fill"),
        Transaction(description: "Daily Streak Bonus", amount: 20, icon: "flame.fill"),
        Transaction(description: "Level Up Reward", amount: 100, icon: "arrow.up.circle.fill"),
        Transaction(description: "Purchased Shield", amount: -30, icon: "shield.fill"),
        Transaction(description: "Completed Quest: Open House", amount: 30, icon: "checkmark.circle.fill")
    ]
}

// Transaction model
struct Transaction: Identifiable {
    var id = UUID()
    var description: String
    var amount: Int
    var icon: String
}

#Preview {
    TreasuryView()
} 