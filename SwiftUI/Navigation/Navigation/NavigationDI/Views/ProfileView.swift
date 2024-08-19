import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var container: DIContainer
    
    var body: some View {
        VStack {
            naviBar
            
            Text("탭바가 안보여야 정상")
            
            Spacer()
        }
//        .toolbar(.hidden, for: .tabBar) // 이거 없으면 항상 노출됨
        .navigationBarBackButtonHidden()
        .onAppear {
            print("@@@ ProfileView - onAppear")
            print("@@@ ProfileView - tabBar isHidden", UITabBar.appearance().isHidden) // 항상 false 인듯
        }
    }
    
    var naviBar: some View {
        HStack {
            Button {
                container.navigationRouter.pop()
            } label: {
                Image(systemName: "arrow.backward")
                    .frame(width: 40, height: 40)
            }
            .padding(.horizontal, 8)
            
            Spacer()
        }
    }
    
}
