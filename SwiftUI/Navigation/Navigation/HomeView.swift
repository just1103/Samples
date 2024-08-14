import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @State private var showLoginSheet = false
    
    var body: some View {
        VStack {
            Text("Current State : \(authViewModel.authenticationState?.rawValue ?? "nil")")
                .padding(.bottom, 30)
            
            Button("찜 <- 게스트이면 로그인 모달 띄움") {
                if authViewModel.authenticationState != .authenticated {
                    showLoginSheet = true
                }
            }
            .padding(.bottom, 30)
            
            Button("Sign Out") {
                authViewModel.send(action: .signOut)
            }
        }
        .padding()
        .onChange(of: authViewModel.authenticationState) { old, newState in
            showLoginSheet = newState == .unauthenticated
        }
        .sheet(isPresented: $showLoginSheet) { // 잘됨
//        .sheet(isPresented: .constant(!authViewModel.isAuthenticated)) { // 이것도 가능
            LoginView()
                .environmentObject(authViewModel)
        }
    }
}
