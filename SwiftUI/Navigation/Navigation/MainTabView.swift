import SwiftUI

enum TabItem {
    case home, profile, settings
}

struct MainTabView: View {
    @EnvironmentObject var container: DIContainer
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @State private var selectedTab: TabItem = .home
    
    @State private var showLoginSheet = false
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(TabItem.home)
            
            Circle()
                .foregroundStyle(Color.yellow)
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
                .tag(TabItem.profile)
            
            Circle()
                .foregroundStyle(Color.blue)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(TabItem.settings)
        }
        .onAppear {
            authViewModel.send(action: .checkAuthenticationState)
        }
//        .onChange(of: authViewModel.authenticationState) { old, newState in
//            showLoginSheet = newState == .unauthenticated
//        }
//        .sheet(isPresented: $showLoginSheet) { // Home에서 로그인/이웃 처리하려면 각 탭아이템뷰에서 띄워야할듯?
//            LoginView()
//                .environmentObject(authViewModel)
//        }
    }
}
