import SwiftUI

struct HomeView: View {
    @EnvironmentObject var container: DIContainer
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @State private var showLoginSheet = false
    
    var body: some View {
        NavigationStack(path: $container.navigationRouter.destinations) {
            VStack(spacing: 30) {
                Text("Current State : \(authViewModel.authenticationState?.rawValue ?? "nil")")
                
                Button("찜 <- 게스트이면 로그인 모달 띄움") {
                    if authViewModel.authenticationState != .authenticated {
                        showLoginSheet = true
                    }
                }
                
                Button("Sign Out") {
                    authViewModel.send(action: .signOut)
                }
                
                // 참고 - NavigationLink-navigationDestination
                // 기존 앱에서는 ScrollView > VStack > ForEach 내부에 있음
                NavigationLink(value: NavigationDestination.loginView) {
                    Text("로그인 액션")
                }
                .navigationDestination(for: NavigationDestination.self) {
                    // !!!: profileView push 이벤트가 여기로 들어옴
                    NavigationRoutingView(destination: $0)
                }
            }
        }
        .onChange(of: authViewModel.authenticationState) { old, newState in
            showLoginSheet = newState == .unauthenticated
        }
        .sheet(isPresented: $showLoginSheet) { 
//        .sheet(isPresented: .constant(!authViewModel.isAuthenticated)) { // 이것도 가능
            LoginView()
                .environmentObject(authViewModel)
        }
        .onAppear {
            print("@@@ HomeView - onAppear")
        }
    }
    
}
