import SwiftUI

/// View for displaying team members and inviting new members
struct TeamView: View {
    // MARK: - Properties
    
    @Environment(\.presentationMode) var presentationMode
    @State private var teamMembers: [TeamMember] = []
    @State private var isLoading = true
    @State private var showingInviteSheet = false
    @State private var inviteEmail = ""
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            // Team members list
            if isLoading {
                loadingView
            } else if teamMembers.isEmpty {
                emptyStateView
            } else {
                teamMembersList
            }
            
            // Invite button
            inviteButton
        }
        .navigationTitle("Thy Fellowship")
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
            loadTeamMembers()
        }
        .sheet(isPresented: $showingInviteSheet) {
            inviteView
        }
        .background(Color("medievalBrown").opacity(0.1).ignoresSafeArea())
    }
    
    // MARK: - Views
    
    /// Loading state view
    private var loadingView: some View {
        VStack {
            Spacer()
            ProgressView()
                .scaleEffect(1.5)
                .progressViewStyle(CircularProgressViewStyle(tint: Color("medievalGold")))
            Text("Summoning thy allies...")
                .font(.headline)
                .foregroundColor(Color("medievalBrown"))
                .padding(.top)
            Spacer()
        }
    }
    
    /// Empty state view when no team members
    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Image(systemName: "person.3.fill")
                .font(.system(size: 60))
                .foregroundColor(Color("medievalGold").opacity(0.5))
            
            Text("No Allies Yet")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(Color("medievalBrown"))
            
            Text("Invite fellow agents to join thy noble quest in the realm of real estate.")
                .multilineTextAlignment(.center)
                .foregroundColor(Color("medievalBrown").opacity(0.8))
                .padding(.horizontal, 40)
            
            Spacer()
        }
    }
    
    /// List of team members
    private var teamMembersList: some View {
        List {
            Section(header: Text("Thy Noble Companions").foregroundColor(Color("medievalBrown"))) {
                ForEach(teamMembers) { member in
                    TeamMemberRow(member: member)
                }
                .onDelete(perform: deleteTeamMember)
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
    
    /// Invite button at bottom of screen
    private var inviteButton: some View {
        Button(action: {
            showingInviteSheet = true
        }) {
            HStack {
                Image(systemName: "envelope.fill")
                Text("Send Royal Invitation")
            }
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color("medievalBrown"))
            .cornerRadius(10)
            .padding()
        }
    }
    
    /// Invite sheet view
    private var inviteView: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "scroll.fill")
                    .font(.system(size: 60))
                    .foregroundColor(Color("medievalGold"))
                    .padding(.top, 30)
                
                Text("Send a Royal Summons")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color("medievalBrown"))
                
                Text("Invite a fellow agent to join thy noble quest in the realm of real estate.")
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color("medievalBrown").opacity(0.8))
                    .padding(.horizontal, 40)
                
                TextField("Enter email address", text: $inviteEmail)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                
                Button(action: sendInvite) {
                    Text("Send Invitation")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("medievalBrown"))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Royal Invitation")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        showingInviteSheet = false
                    }
                }
            }
            .background(Color("medievalBrown").opacity(0.1).ignoresSafeArea())
        }
    }
    
    // MARK: - Methods
    
    /// Load team members from data source
    private func loadTeamMembers() {
        // Simulate loading from a data source
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // In a real app, this would fetch from a database
            // For now, we'll use sample data
            self.teamMembers = [
                TeamMember(
                    id: UUID().uuidString,
                    name: "Sir Lancelot",
                    email: "lancelot@camelot.com",
                    role: .owner,
                    joinDate: Date().addingTimeInterval(-60*60*24*30), // 30 days ago
                    profileImageUrl: nil,
                    isActive: true
                ),
                TeamMember(
                    id: UUID().uuidString,
                    name: "Lady Guinevere",
                    email: "guinevere@camelot.com",
                    role: .admin,
                    joinDate: Date().addingTimeInterval(-60*60*24*15), // 15 days ago
                    profileImageUrl: nil,
                    isActive: true
                ),
                TeamMember(
                    id: UUID().uuidString,
                    name: "Merlin",
                    email: "merlin@camelot.com",
                    role: .member,
                    joinDate: Date().addingTimeInterval(-60*60*24*5), // 5 days ago
                    profileImageUrl: nil,
                    isActive: false,
                    invitePending: true
                )
            ]
            
            self.isLoading = false
        }
    }
    
    /// Delete a team member
    private func deleteTeamMember(at offsets: IndexSet) {
        teamMembers.remove(atOffsets: offsets)
    }
    
    /// Send an invitation to a new team member
    private func sendInvite() {
        guard !inviteEmail.isEmpty else { return }
        
        // In a real app, this would send an invitation email
        // For now, we'll just add a pending team member
        let newMember = TeamMember(
            id: UUID().uuidString,
            name: "New Member",
            email: inviteEmail,
            role: .member,
            joinDate: Date(),
            profileImageUrl: nil,
            isActive: false,
            invitePending: true
        )
        
        teamMembers.append(newMember)
        inviteEmail = ""
        showingInviteSheet = false
    }
}

// MARK: - Supporting Views

/// Row for displaying a team member
struct TeamMemberRow: View {
    let member: TeamMember
    
    var body: some View {
        HStack(spacing: 16) {
            // Profile image
            ZStack {
                Circle()
                    .fill(Color("medievalGold").opacity(0.2))
                    .frame(width: 50, height: 50)
                
                Text(initials)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color("medievalBrown"))
            }
            
            // Member details
            VStack(alignment: .leading, spacing: 4) {
                Text(member.name)
                    .font(.headline)
                    .foregroundColor(Color("medievalBrown"))
                
                Text(member.email)
                    .font(.subheadline)
                    .foregroundColor(Color("medievalBrown").opacity(0.8))
                
                HStack {
                    Text(roleText)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(roleColor.opacity(0.2))
                        .foregroundColor(roleColor)
                        .cornerRadius(4)
                    
                    if member.invitePending {
                        Text("Awaiting Response")
                            .font(.caption)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 2)
                            .background(Color.orange.opacity(0.2))
                            .foregroundColor(Color.orange)
                            .cornerRadius(4)
                    }
                }
            }
            
            Spacer()
            
            // Status indicator
            Circle()
                .fill(member.isActive ? Color.green : Color.gray)
                .frame(width: 10, height: 10)
        }
    }
    
    // MARK: - Helper Properties
    
    /// Get initials from name
    private var initials: String {
        let components = member.name.components(separatedBy: " ")
        if components.count > 1, 
           let first = components.first?.first,
           let last = components.last?.first {
            return "\(first)\(last)"
        } else if let first = components.first?.first {
            return "\(first)"
        }
        return "?"
    }
    
    /// Get role text
    private var roleText: String {
        switch member.role {
        case .owner:
            return "Monarch"
        case .admin:
            return "Noble"
        case .member:
            return "Knight"
        }
    }
    
    /// Get role color
    private var roleColor: Color {
        switch member.role {
        case .owner:
            return Color.purple
        case .admin:
            return Color.blue
        case .member:
            return Color.green
        }
    }
}

// MARK: - Preview

struct TeamView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TeamView()
        }
    }
} 