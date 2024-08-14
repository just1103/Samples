import SwiftUI

// NavigationRouter에서 띄울 뷰를 알려주는 역할
struct NavigationRoutingView: View {
    @EnvironmentObject var container: DIContainer
    @State var destination: NavigationDestination
    
    var body: some View {
        // destination 전달받으면 띄울 뷰를 반환
        switch destination {
        case .loginView:
            LoginView()
        }
    }
}
