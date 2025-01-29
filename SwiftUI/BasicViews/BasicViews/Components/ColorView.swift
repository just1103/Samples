import SwiftUI

struct ColorView: View {
    
    var body: some View {
        ZStack {
            // Rectangle은 Shape
            Rectangle()
                .fill(Color.blue)
            
            // Color는 View
            // 배경색 깔고, 탭 감지할 때 사용
            Color.white.opacity(0.5)
                .onTapGesture {
                    print("@@@ Color Tapped !")
                }
        }
    }
}

#Preview {
    ColorView()
}
