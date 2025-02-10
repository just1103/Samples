import SwiftUI

// task
// 비동기 작업은 onAppear 대신 task에서 진행하자 (iOS 15+)
// https://developer.apple.com/documentation/swiftui/view/task(priority:_:)
// https://developer.apple.com/documentation/swiftui/view/task(id:priority:_:)

// onAppear : 할당한 작업이 complete 되면 View를 노출함
// task : 할당한 작업과 View의 수명이 일치함 (작업 중에 View 사라지면, 작업 취소됨)
// 또는 id 할당한 경우, 해당 id 값이 바뀌면 작업을 취소 및 재시작해줌

// 의외 - onAppear -> task 순으로 실행됨

struct TaskView: View {
    
    var body: some View {
        
        NavigationStack {
            
            NavigationLink("Go to Child View", value: "10")
                .navigationDestination(for: String.self) { value in
                    ChildView(value: value)
                }
                // 1. 백버튼으로 되돌아올 때 다시 호출됨
                .task {
                    print("TaskView Child : task started !")
                    try? await Task.sleep(nanoseconds: 2_000_000_000) // 2초 대기
                    print("TaskView Child : task done !")
                }
                .onAppear {
                    print("TaskView Child : appeared !")
                }
        }
        // 2. 백버튼으로 되돌아올 때 다시 호출 안됨 (!)
//        .task {
//            print("TaskView : task started !")
//        }
//        .onAppear {
//            print("TaskView : appeared !")
//        }
    }
}

extension TaskView {
    
    struct ChildView: View {
        let value: String
        
        var body: some View {
            ZStack {
                Rectangle()
                    .fill(Color.random)
                Text("Child Number : \(value)")
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

#Preview {
    TaskView()
}
