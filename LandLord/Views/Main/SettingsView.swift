//
//  SettingsView.swift
//  LandLord
//
//  Created for bunkeboyLandLord2
//  Medieval 8-bit themed real estate app
//

import SwiftUI

struct SettingsView: View {
    // Auth view model would be injected in a real app
    @State private var showSignOutAlert = false
    
    // User settings
    @State private var notificationsEnabled = true
    @State private var vacationMode = false
    @State private var soundEffectsVolume: Double = 70
    @State private var backgroundMusicVolume: Double = 50
    
    // Placeholder user data
    private let userName = "Sir Lancelot"
    private let userEmail = "lancelot@camelot.com"
    private let userRank = "Knight"
    
    // App version
    private let appVersion = "1.0.0"
    
    // Medieval theme colors
    private let primaryColor = ThemeManager.primaryColor
    private let accentColor = ThemeManager.accentColor
    private let backgroundColor = ThemeManager.backgroundPrimary
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background
                backgroundColor.ignoresSafeArea()
                
                Form {
                    // Profile section
                    Section {
                        HStack(spacing: 15) {
                            // Avatar
                            ZStack {
                                Circle()
                                    .fill(ThemeManager.secondaryColor)
                                    .frame(width: 70, height: 70)
                                
                                Text(String(userName.prefix(1)))
                                    .font(.system(size: 30, weight: .bold))
                                    .foregroundColor(.white)
                            }
                            
                            // User info
                            VStack(alignment: .leading, spacing: 5) {
                                Text(userName)
                                    .font(.headline)
                                
                                Text(userEmail)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                
                                HStack {
                                    Image(systemName: "crown.fill")
                                        .foregroundColor(accentColor)
                                    
                                    Text(userRank)
                                        .font(.caption)
                                        .foregroundColor(primaryColor)
                                }
                            }
                            
                            Spacer()
                            
                            // Edit button
                            Button(action: {
                                // Would navigate to profile edit screen
                            }) {
                                Text("Edit")
                                    .font(.caption)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color.gray.opacity(0.2))
                                    )
                                    .foregroundColor(primaryColor)
                            }
                        }
                        .padding(.vertical, 8)
                    } header: {
                        SectionHeader(title: "Royal Identity")
                    }
                    .listRowBackground(Color.white.opacity(0.7))
                    
                    // Notification settings
                    Section {
                        Toggle(isOn: $notificationsEnabled) {
                            HStack {
                                Image(systemName: "bell.fill")
                                    .foregroundColor(accentColor)
                                
                                Text("Royal Proclamations")
                                    .foregroundColor(primaryColor)
                            }
                        }
                        .toggleStyle(SwitchToggleStyle(tint: accentColor))
                        
                        Toggle(isOn: $vacationMode) {
                            HStack {
                                Image(systemName: "tent.fill")
                                    .foregroundColor(accentColor)
                                
                                VStack(alignment: .leading) {
                                    Text("Vacation Mode")
                                        .foregroundColor(primaryColor)
                                    
                                    Text("Pause thy daily quests")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .toggleStyle(SwitchToggleStyle(tint: accentColor))
                    } header: {
                        SectionHeader(title: "Kingdom Notifications")
                    }
                    .listRowBackground(Color.white.opacity(0.7))
                    
                    // Sound settings
                    Section {
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: "speaker.wave.2.fill")
                                    .foregroundColor(accentColor)
                                
                                Text("Sound Effects")
                                    .foregroundColor(primaryColor)
                                
                                Spacer()
                                
                                Text("\(Int(soundEffectsVolume))")
                                    .foregroundColor(.gray)
                            }
                            
                            Slider(value: $soundEffectsVolume, in: 0...100, step: 1)
                                .accentColor(accentColor)
                        }
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: "music.note")
                                    .foregroundColor(accentColor)
                                
                                Text("Background Music")
                                    .foregroundColor(primaryColor)
                                
                                Spacer()
                                
                                Text("\(Int(backgroundMusicVolume))")
                                    .foregroundColor(.gray)
                            }
                            
                            Slider(value: $backgroundMusicVolume, in: 0...100, step: 1)
                                .accentColor(accentColor)
                        }
                    } header: {
                        SectionHeader(title: "Royal Orchestra")
                    }
                    .listRowBackground(Color.white.opacity(0.7))
                    
                    // Game settings
                    Section {
                        NavigationLink(destination: Text("Shield Regeneration Settings")) {
                            HStack {
                                Image(systemName: "shield.fill")
                                    .foregroundColor(accentColor)
                                
                                Text("Shield Regeneration")
                                    .foregroundColor(primaryColor)
                            }
                        }
                        
                        NavigationLink(destination: Text("Quest Difficulty Settings")) {
                            HStack {
                                Image(systemName: "scroll.fill")
                                    .foregroundColor(accentColor)
                                
                                Text("Quest Difficulty")
                                    .foregroundColor(primaryColor)
                            }
                        }
                        
                        NavigationLink(destination: Text("Appearance Settings")) {
                            HStack {
                                Image(systemName: "paintbrush.fill")
                                    .foregroundColor(accentColor)
                                
                                Text("Kingdom Appearance")
                                    .foregroundColor(primaryColor)
                            }
                        }
                    } header: {
                        SectionHeader(title: "Game Settings")
                    }
                    .listRowBackground(Color.white.opacity(0.7))
                    
                    // About section
                    Section {
                        HStack {
                            Text("App Version")
                                .foregroundColor(primaryColor)
                            
                            Spacer()
                            
                            Text(appVersion)
                                .foregroundColor(.gray)
                        }
                        
                        NavigationLink(destination: Text("Terms and Conditions")) {
                            Text("Royal Decree (Terms)")
                                .foregroundColor(primaryColor)
                        }
                        
                        NavigationLink(destination: Text("Privacy Policy")) {
                            Text("Privacy Scroll")
                                .foregroundColor(primaryColor)
                        }
                    } header: {
                        SectionHeader(title: "About the Realm")
                    }
                    .listRowBackground(Color.white.opacity(0.7))
                    
                    // Sign out button
                    Section {
                        Button(action: {
                            showSignOutAlert = true
                        }) {
                            HStack {
                                Spacer()
                                
                                Text("Abandon Thy Quest (Sign Out)")
                                    .foregroundColor(.red)
                                
                                Spacer()
                            }
                        }
                    }
                    .listRowBackground(Color.white.opacity(0.7))
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Kingdom Settings")
            .navigationBarTitleDisplayMode(.inline)
            .alert(isPresented: $showSignOutAlert) {
                Alert(
                    title: Text("Abandon Thy Quest?"),
                    message: Text("Art thou sure thou wishest to sign out from thy kingdom?"),
                    primaryButton: .destructive(Text("Aye, Sign Out")) {
                        // Would call AuthViewModel.signOut() in a real app
                        print("User signed out")
                    },
                    secondaryButton: .cancel(Text("Nay, Stay"))
                )
            }
        }
    }
}

// Custom section header with medieval styling
struct SectionHeader: View {
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.custom("Papyrus", size: 14, relativeTo: .headline))
                .foregroundColor(ThemeManager.primaryColor)
                .textCase(nil)
            
            Spacer()
            
            // Decorative element
            Image(systemName: "scroll.fill")
                .font(.system(size: 12))
                .foregroundColor(ThemeManager.accentColor.opacity(0.5))
        }
    }
}

#Preview {
    SettingsView()
} 