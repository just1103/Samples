import SwiftUI

// https://developer.apple.com/documentation/swiftui/laying-out-a-simple-view
// https://developer.apple.com/documentation/swiftui/picking-container-views-for-your-content
// https://developer.apple.com/documentation/swiftui/aligning-views-within-a-stack

struct CardItemView: View {
    
    // view container를 적절히 섞어서 쓰는게 키포인트
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                // 핑크 네모 기준
                // 상하좌우 padding = 8 / 24 / 16 / 16
                // 핑크 네모가 1:1이면, 하+좌우만 설정해도 top이 결정됨
                // 근데 왜 상=(1) 없으면 안그려지지? -> 초록 네모가 작아져서 (!)
                Spacer()
                    .frame(height: 8)
                
                Rectangle()
                    .foregroundColor(.pink)
//                    .aspectRatio(1, contentMode: .fit) // (1)
                    .padding(.horizontal, 16) // 주의 - 위랑 순서 바뀌면 달라짐

                Spacer()
                    .frame(height: 24)
            }
            .aspectRatio(1, contentMode: .fit) // 이게 있으면 (1) 없어도 자리 잘 잡음
            .background(Color.green)

            Text("Hello Card Layout! Hello Card Layout! Hello Card Layout! Hello Card Layout!")
                .multilineTextAlignment(.center)
//                .lineLimit(1)
                .lineLimit(2)
                .frame(maxWidth: .infinity)
                .background(Color.yellow.opacity(0.6))
                .padding(.horizontal, 4)
                .offset(y: -8)
        }
    }
}

#Preview {
    CardItemView()
}
