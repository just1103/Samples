import SwiftUI

// onAppaer에서 너무 많은 작업을 하면 안됨 (그동안 화면이 노출되지 않음)
// https://developer.apple.com/documentation/swiftui/view/onappear(perform:)

struct OnAppearView: View {
    @State private var data: String = "Loading..."
    @State private var index: Int = 0

    var body: some View {
        
        Button {
            index = Int.random(in: 10..<100)
        } label: {
            Text("\(index)")
                .padding()
                .background(Color.random)
        }
        
        Text(data)
//          .onAppear {
              // 항상 메인스레드에게 작업이 할당됨 (!)
              // 이 작업이 complete된 이후에 뷰가 화면에 노출됨
              // 즉, "Loading" 텍스트는 노출되지 않음
//              performBlockingTask()
//              performNonBlockingTask()
//          }
          .task {
              // 이것도 기본 메인 스레드에 할당되는거 같은데?
              // Loading 중에는 버튼 탭 안먹힘;
              performBlockingTask()
              
//              performNonBlockingTask()
          }
    }
    
    func performBlockingTask() {
        // 의도적으로 메인 스레드를 차단
        let result = intensiveCalculation()
        data = result
    }
    
    func performNonBlockingTask() {
        DispatchQueue.global().async {
            let result = intensiveCalculation()
            DispatchQueue.main.async {
                data = result
            }
        }
    }

    // 계산량이 많은 작업
    func intensiveCalculation() -> String {
        var sum = 0
        for _ in 0..<100_000_000 {
            sum += 1
        }
        return "Calculation Complete"
    }
}

#Preview {
    OnAppearView()
}
