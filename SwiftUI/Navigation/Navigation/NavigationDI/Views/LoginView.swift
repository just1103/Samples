import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
     
    var body: some View {
        VStack {
            Text("Current State : \(authViewModel.authenticationState?.rawValue ?? "nil")")
                .padding(.bottom, 30)
            
            Button("Sign In") {
                authViewModel.send(action: .signIn)
            }
        }
        .padding()
    }
}
