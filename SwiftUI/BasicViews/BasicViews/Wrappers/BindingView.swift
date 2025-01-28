import SwiftUI

struct BindingView: View {
    
    @State private var isPlaying: Bool = false
    
    var body: some View {
        Text(isPlaying ? "Paused ..." : "Playing ...")
        
        ChildView(isPlaying: $isPlaying)
        
        ChildView(isPlaying: $isPlaying)
    }
}

struct ChildView: View {
    
    // 상위 뷰가 소유한 프로퍼티이므로
    // 하위 뷰는 소유권/저장공간이 없음
    @Binding var isPlaying: Bool
    
    var body: some View {
        Button(isPlaying ? "Pause" : "Play") {
            // 하위 뷰 <-> 상위 뷰 변경사항 공유됨
            isPlaying.toggle()
        }
        .foregroundStyle(Color.white)
        .padding()
        .background(Color.random)
    }
}

#Preview {
    BindingView()
}
