import SwiftUI

class ProgressModel: ObservableObject {
    @Published var progress: Float = 0 // 진행률 (0 ~ 1)
}

// Q. 만약 Timer를 사용하고 싶다면?
// 구조체 내부에서 Timer 만들면 mutating 메서드 필요해서 구현 까다로움
// -> class 타입 ViewModel이 timer를 갖게 하고, ViewModel 내의 원하는 값 업데이트 하도록 (!)
struct ProgressBarView: View {
    
    // 둘다 가능
//    @StateObject private var progressModel = ProgressModel()
    @State private var progress: Float = 0
    
    var body: some View {
        Button("+") {
            if progress <= 1 {
                progress += 0.1
            }
//            if progressModel.progress <= 1 {
//                progressModel.progress += 0.1
//            }
        }
        
        ProgressBar(progress: progress)
//        ProgressBar(progress: progressModel.progress)
            .frame(height: 5)
            .padding()
    }
}

extension ProgressBarView {
    
    struct ProgressBar: View {
        var progress: Float

        var body: some View {
            
            // GeometryReader
            // 자식 뷰가 사용할 수 있는 뷰의 크기와 위치 정보를 제공하는 컨테이너 뷰
            // 부모 뷰를 기준으로 꽉 차게 그리면서 비율 조정하고 싶을 때 활용
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.gray)
                    
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: CGFloat(progress) * geometry.size.width)
                }
            }
        }
    }
}

#Preview {
    ProgressBarView()
}
