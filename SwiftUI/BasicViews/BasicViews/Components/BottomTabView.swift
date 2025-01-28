import SwiftUI

struct BottomTabView: View {
    
    @State private var selectedIndex: Int = 0
    
    var body: some View {
        VStack {
            Button("Change index-1 Tab") {
                selectedIndex = 1
            }
            
            TabView(selection: $selectedIndex) {
                Rectangle()
                    .fill(Color.yellow)
                    .tabItem {
                        Label("Sun", systemImage: "sun.max")
                    }
                    .tag(0)
                
                Rectangle()
                    .fill(Color.green)
                    .tabItem {
                        Label("Snow", systemImage: "snow")
                    }
                    .tag(1)
                
                Rectangle()
                    .fill(Color.gray)
                    .tabItem {
                        Label("Rain", systemImage: "cloud.rain")
                    }
                    .tag(2)
            }
//            .tabViewStyle(.automatic) // 기본 하단 탭바
//            .tabViewStyle(.page) // pageViewController 처럼 동작
//            .tabViewStyle(.page(indexDisplayMode: .never)) // pageControl 숨김
        }
    }
}

#Preview {
    BottomTabView()
}
