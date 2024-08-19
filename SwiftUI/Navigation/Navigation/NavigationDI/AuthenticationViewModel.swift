import Foundation
import Combine

enum AuthenticationState: String {
    case authenticated
    case unauthenticated
}

enum AuthenticationAction {
    case checkAuthenticationState
    case signIn
    case signOut
}

class AuthenticationViewModel: ObservableObject {
    @Published var authenticationState: AuthenticationState? = nil
//    @Published var authenticationState: AuthenticationState = .unauthenticated
    
    func send(action: AuthenticationAction) {
        switch action {
        case .checkAuthenticationState:
            // 예제 - 자동로그인 안되도록 처리
            // API 오류나서 한번에 체크 못하면 어떻게 처리? -> 게스트로 취급
            self.authenticationState = .authenticated
//            self.authenticationState = .unauthenticated
        case .signIn:
            self.authenticationState = .authenticated
        case .signOut:
            self.authenticationState = .unauthenticated
        }
    }
}
