import SwiftUI

struct OverlayView: View {
    
    var body: some View {
        // 1 - ZStack에 들어가는 뷰는 서로 독립적
        ZStack {
            Rectangle()
                .fill(Color.green)
                .frame(width: 100, height: 100)
//                .zIndex(1) // 순서 뒤집기
            
            Rectangle()
                .fill(Color.yellow)
                .frame(width: 100, height: 100)
                .offset(x: 20, y: 20)
        }
        .padding(.bottom, 50)
        
        // 2 - overlay는 기준 뷰에 소속됨, 위에 얹어짐 (zIndex 의미 없음)
        Rectangle()
            .fill(Color.green)
            .frame(width: 100, height: 100)
            .zIndex(1) // overlay 위로 안올라옴
            .overlay {
                Rectangle()
                    .fill(Color.yellow)
                    .frame(width: 100, height: 100)
                    .offset(x: 20, y: 20)
            }
            .overlay() {
//            .overlay(alignment: .bottomLeading) { // frame size가 같아서 무의미
//            .overlay(alignment: .bottomTrailing) {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 100, height: 100)
                    .offset(x: 40, y: 40)
            }
            .padding(.bottom, 50)
            
        // overlay alignment 참고
        RoundedRectangle(cornerRadius: 8)
            .foregroundStyle(Color.blue)
            .frame(width: 100, height: 100)
            .overlay(alignment: .topLeading) {
                Circle()
                .frame(width: 20, height: 20)
                .foregroundStyle(Color.red)
                .offset(x: 10, y: 10) // 좌상단에서 더 안쪽으로
            }
            .overlay(alignment: .topTrailing) {
                Circle()
                .frame(width: 20, height: 20)
                .foregroundStyle(Color.yellow)
            }
            .overlay(alignment: .bottomLeading) {
                Circle()
                .frame(width: 20, height: 20)
                .foregroundStyle(Color.green)
            }
            .overlay(alignment: .bottomTrailing) {
                Circle()
                .frame(width: 20, height: 20)
                .foregroundStyle(Color.purple)
                .offset(x: 10, y: 10) // 우하단에서 더 바깥으로
            }
    }
}

#Preview {
    OverlayView()
}
