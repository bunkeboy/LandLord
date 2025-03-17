//
//  QuestsView.swift
//  LandLord
//
//  Created for bunkeboyLandLord2
//  Medieval 8-bit themed real estate app
//

import SwiftUI

struct QuestsView: View {
    // Use the QuestsViewModel
    @StateObject private var viewModel = QuestsViewModel()
    
    // Medieval theme colors
    private let primaryColor = Color("medievalBrown") // Brown
    private let goldColor = Color("medievalGold") // Gold
    private let backgroundColor = Color(red: 225/255, green: 193/255, blue: 110/255) // Parchment
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background
                backgroundColor.ignoresSafeArea()
                
                VStack(spacing: 16) {
                    // Medieval header
                    Text("Daily Quests")
                        .font(.custom("Papyrus", size: 32, relativeTo: .title))
                        .foregroundColor(primaryColor)
                        .padding(.top, 20)
                        .padding(.bottom, 10)
                    
                    // Shield counter
                    HStack {
                        Spacer()
                        
                        HStack(spacing: 4) {
                            ForEach(0..<viewModel.maxShieldCount, id: \.self) { index in
                                Image(systemName: index < viewModel.shieldCount ? "shield.fill" : "shield")
                                    .foregroundColor(index < viewModel.shieldCount ? .red : .gray)
                                    .font(.system(size: 18))
                            }
                        }
                        Text("\(viewModel.shieldCount)/\(viewModel.maxShieldCount)")
                            .font(.headline)
                            .foregroundColor(primaryColor)
                    }
                    .padding(.horizontal)
                    
                    // Quest list
                    List {
                        ForEach(viewModel.quests) { quest in
                            QuestRowView(quest: quest, onComplete: {
                                viewModel.completeQuest(id: quest.id)
                            })
                            .listRowBackground(Color.white.opacity(0.7))
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                    
                    // Total gold earned
                    HStack {
                        Text("Gold Earned Today:")
                            .font(.headline)
                            .foregroundColor(primaryColor)
                        
                        Text("\(viewModel.calculateGoldEarned())")
                            .font(.headline)
                            .foregroundColor(goldColor)
                        
                        Image(systemName: "coins.fill")
                            .foregroundColor(goldColor)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.white.opacity(0.7))
                            .shadow(radius: 2)
                    )
                    .padding(.bottom)
                }
                .padding()
            }
            .navigationTitle("Royal Quests")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Quest Row View

struct QuestRowView: View {
    let quest: Quest
    let onComplete: () -> Void
    
    // Medieval theme colors
    private let primaryColor = Color("medievalBrown") // Brown
    private let goldColor = Color("medievalGold") // Gold
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Quest completion toggle
            Button(action: {
                onComplete()
            }) {
                ZStack {
                    Circle()
                        .stroke(primaryColor, lineWidth: 2)
                        .frame(width: 30, height: 30)
                    
                    if quest.status == .completed {
                        Image(systemName: "checkmark")
                            .foregroundColor(primaryColor)
                            .font(.system(size: 16, weight: .bold))
                    }
                }
            }
            .buttonStyle(PlainButtonStyle())
            .frame(width: 30, height: 30)
            
            // Quest details
            VStack(alignment: .leading, spacing: 6) {
                Text(quest.title)
                    .font(.headline)
                    .foregroundColor(quest.status == .completed ? .gray : primaryColor)
                    .strikethrough(quest.status == .completed)
                
                Text(quest.description)
                    .font(.subheadline)
                    .foregroundColor(quest.status == .completed ? .gray : .secondary)
                    .strikethrough(quest.status == .completed)
                
                // Gold reward
                HStack {
                    Image(systemName: "coins.fill")
                        .foregroundColor(goldColor)
                    
                    Text("\(quest.goldReward) gold")
                        .font(.subheadline)
                        .foregroundColor(goldColor)
                }
                .padding(.top, 4)
            }
            
            Spacer()
            
            // Complete button
            if quest.status != .completed {
                Button(action: {
                    onComplete()
                }) {
                    Text("Complete")
                        .font(.caption)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(primaryColor)
                        )
                        .foregroundColor(.white)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.vertical, 8)
        .opacity(quest.status == .completed ? 0.7 : 1.0)
    }
}

#Preview {
    QuestsView()
} 