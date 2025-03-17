import SwiftUI
import Firebase
import FirebaseAuth

@main
struct LandLordApp: App {
    
    // MARK: - Properties
    
    /// Authentication view model
    @StateObject private var authViewModel = AuthViewModel()
    
    /// Quests view model
    @StateObject private var questsViewModel = QuestsViewModel()
    
    /// Navigation handler for app-wide navigation
    @StateObject private var navigationHandler = NavigationHandler()
    
    /// Tracks whether user is authenticated
    @AppStorage("isAuthenticated") private var isAuthenticated = false
    
    /// Tracks whether onboarding is complete
    @AppStorage("onboardingComplete") private var onboardingComplete = false
    
    // MARK: - Initialization
    
    init() {
        // Initialize Firebase
        configureFirebase()
        
        // Apply theme settings
        configureAppAppearance()
        
        // Log app launch for debugging
        print("🏰 LandLordApp: Medieval realm initialized")
    }
    
    // MARK: - Body
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                // Main content
                Group {
                    if !isAuthenticated {
                        // User is not authenticated, show login
                        LoginView()
                            .transition(.opacity)
                    } else if !onboardingComplete {
                        // User is authenticated but hasn't completed onboarding
                        OnboardingView()
                            .transition(.opacity)
                    } else {
                        // User is authenticated and has completed onboarding
                        MainTabView()
                            .transition(.opacity)
                    }
                }
                .environmentObject(authViewModel)
                .environmentObject(questsViewModel)
                .environmentObject(navigationHandler)
                
                // Debug menu (only in DEBUG builds)
                #if DEBUG
                DebugMenu()
                #endif
            }
            .onAppear {
                // Check if we need to refresh the authentication state
                authViewModel.checkAuthState()
                
                // Load user data if authenticated
                if isAuthenticated {
                    authViewModel.loadUserData()
                    questsViewModel.loadQuests()
                }
            }
        }
    }
    
    // MARK: - Helper Methods
    
    /// Configure Firebase
    private func configureFirebase() {
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
    }
    
    /// Configure app appearance
    private func configureAppAppearance() {
        // Set navigation bar appearance
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(ThemeManager.primaryColor.opacity(0.9))
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor(ThemeManager.accentColor),
            .font: UIFont(name: "Papyrus", size: 20) ?? .systemFont(ofSize: 20, weight: .bold)
        ]
        
        // Apply to all navigation bars
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        // Set tab bar appearance
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor(ThemeManager.primaryColor.opacity(0.9))
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    }
}

// MARK: - View Models

// MARK: - Navigation Handler

/// Handles app-wide navigation
class NavigationHandler: ObservableObject {
    @Published var activeTab: Tab = .quests
    @Published var showAchievements = false
    @Published var showSettings = false
    @Published var showTeamView = false
    
    enum Tab {
        case quests, profile, marketplace, rewards
    }
    
    func navigateTo(_ tab: Tab) {
        activeTab = tab
    }
}

// MARK: - Main Tab View

/// Main tab interface showing quests, profile, marketplace and rewards
struct MainTabView: View {
    @EnvironmentObject var navigationHandler: NavigationHandler
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var questsViewModel: QuestsViewModel
    
    // Selected tab
    @State private var selectedTab = 0
    
    // Medieval theme colors
    private let tabBarColor = Color("royalPurple") // Deep Purple
    private let tabSelectedColor = Color("medievalGold") // Gold
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Quests tab
            NavigationView {
                QuestsView()
                    .navigationTitle("Royal Quests")
            }
            .tabItem {
                Label("Quests", systemImage: "scroll.fill")
            }
            .tag(0)
            
            // Profile tab
            NavigationView {
                ProfileView()
                    .navigationTitle("Thy Profile")
            }
            .tabItem {
                Label("Profile", systemImage: "person.crop.circle")
            }
            .tag(1)
            
            // Marketplace tab
            NavigationView {
                MarketplaceView()
                    .navigationTitle("Marketplace")
            }
            .tabItem {
                Label("Market", systemImage: "building.columns")
            }
            .tag(2)
            
            // Rewards tab
            NavigationView {
                RewardsView()
                    .navigationTitle("Treasury")
            }
            .tabItem {
                Label("Rewards", systemImage: "crown")
            }
            .tag(3)
        }
        .accentColor(tabSelectedColor) // Selected tab color
        .onAppear {
            // Style the tab bar with medieval theme
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(tabBarColor)
            
            // Style the selected and unselected items
            let itemAppearance = UITabBarItemAppearance()
            
            // Selected item
            itemAppearance.selected.iconColor = UIColor(tabSelectedColor)
            itemAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(tabSelectedColor)]
            
            // Normal item
            itemAppearance.normal.iconColor = UIColor.white
            itemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
            
            appearance.stackedLayoutAppearance = itemAppearance
            appearance.inlineLayoutAppearance = itemAppearance
            appearance.compactInlineLayoutAppearance = itemAppearance
            
            // Apply the appearance
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
            
            // Make tab bar always visible
            UITabBar.appearance().isTranslucent = false
        }
    }
}

// MARK: - Placeholder Views

/// Placeholder for QuestsView
struct QuestsView: View {
    var body: some View {
        Text("Thy Quests Await, Noble Agent!")
            .font(.largeTitle)
    }
}

/// Placeholder for ProfileView
struct ProfileView: View {
    var body: some View {
        Text("Thy Royal Profile")
            .font(.largeTitle)
    }
}

/// Placeholder for MarketplaceView
struct MarketplaceView: View {
    var body: some View {
        Text("The Royal Marketplace")
            .font(.largeTitle)
    }
}

/// Placeholder for RewardsView
struct RewardsView: View {
    var body: some View {
        Text("Thy Royal Treasury")
            .font(.largeTitle)
    }
}

/// Placeholder for TeamView
struct TeamView: View {
    var body: some View {
        Text("Thy Noble Fellowship")
            .font(.largeTitle)
    }
} 
