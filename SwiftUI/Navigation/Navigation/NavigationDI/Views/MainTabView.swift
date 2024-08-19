import SwiftUI

enum TabItem: CaseIterable {
    case home, profile, settings
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .profile:
            return "Profile"
        case .settings:
            return "Settings"
        }
    }
    
    var icon: String {
        switch self {
        case .home:
            return "house"
        case .profile:
            return "person"
        case .settings:
            return "gear"
        }
    }
}

struct MainTabView: View {
    @EnvironmentObject var container: DIContainer
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @State private var selectedTab: TabItem = .home
    
    @State private var showLoginSheet = false
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(TabItem.allCases, id: \.self) { tab in
                Group {
                    switch tab {
                    case .home:
                        HomeView()
                            .environmentObject(container)
                    case .profile:
                        Circle() // 실제로는 안보이는 뷰
                            .foregroundStyle(Color.yellow)
                    case .settings:
                        Circle()
                            .foregroundStyle(Color.blue)
                    }
                }
                .tabItem {
                    Label(tab.title, systemImage: tab.icon)
                        .environment(\.symbolVariants, .none)
                }
                .tag(tab)
            }
        }
        .onAppear {
            print("@@@ MainTab - onAppear")
            authViewModel.send(action: .checkAuthenticationState)
        }
        .onChange(of: selectedTab) { _, newTab in
            print("@@@ MainTab - newTab", newTab)
            // !!!: 기존 탭의 navigationStack에 push
            if newTab == .profile {
                selectedTab = .home
                container.navigationRouter.push(to: .profileView)
            }
        }

    }
}
