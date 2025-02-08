import SwiftUI

struct CardListView: View {
    
    var body: some View {
        VStack(spacing: 30) {
            CardItemView()
//                .frame(width: 100, height: 100)
            
            // 같아 보이지만 사실 세로로 gray bg가 노출됨. 즉 ItemView가 늘어남
            // -> ItemView 자체에 1:1을 설정해서 해결
//                .frame(width: 100)
            
            // Text가 양옆으로 늘어남. 이것도 가로로 gray bg가 노출됨. 즉 ItemView가 늘어남
            // -> ItemView 자체에 1:1을 설정해서 해결
                .frame(height: 100)
            
            
            CardItemView()
                .frame(width: 200, height: 200)
            
            CardItemView()
                .frame(width: 300, height: 300)
        }
    }
}

#Preview {
    CardListView()
}
