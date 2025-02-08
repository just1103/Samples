import SwiftUI

struct CardListView: View {
    
    var body: some View {
        VStack(spacing: 50) {
            CardItemView()
                .frame(width: 100) // 아래와 동일 (내부적으로 1:1 ratio 설정해서)
//                .frame(height: 100) // Text가 양옆으로 늘어남 -> ???: superview 보다 튀어나가지 않게 어떻게 설정하지? (clipsToBounds 같은거)
//                .frame(width: 100, height: 100)
            
            CardItemView()
                .frame(width: 200)
            
            CardItemView()
                .frame(width: 300)
        }
    }
}

#Preview {
    CardListView()
}
