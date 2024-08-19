import SwiftUI

// NavigationRouter에서 띄울 뷰를 알려주는 역할
struct NavigationRoutingView: View {
    @EnvironmentObject var container: DIContainer
    @State var destination: NavigationDestination
    
    var body: some View {
        
        switch destination {
        case .loginView:
            LoginView()
        case .profileView:
            // FIXME: 탭바 숨겨지지 않는 버그 발생 (profile탭 최초 접근 시, 간헐적으로)
            // 뭔가 세팅이 덜 됐을 때, 탭을 누르면 그런건가?
            Circle()
                .toolbar(.hidden, for: .tabBar) // 이거 없으면 항상 노출됨
                .onAppear {
                    print("@@@ Circle - onAppear")
                }
            
            // 더 자주 안 숨겨짐
//            ProfileView()
        }
    }
}
