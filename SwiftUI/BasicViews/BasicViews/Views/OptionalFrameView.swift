import SwiftUI

// nil 지정 == frame 지정 안한 것과 동일
// 시스템이 임의로 크기를 계산해줌

struct OptionalFrameView: View {
    
    var body: some View {
        Rectangle()
            .fill(Color.red)
            .frame(width: 200, height: nil)
        
        Rectangle()
            .fill(Color.green)
            .frame(width: nil, height: 100)
        
        Rectangle()
            .fill(Color.yellow)
            .frame(width: nil, height: nil)
        
        Rectangle()
            .fill(Color.blue)
    }
}

#Preview {
    OptionalFrameView()
}
