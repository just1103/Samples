import SwiftUI

struct NavigationView2: View {
    
    // 단일 데이터 -> array 사용 
    // 다중 데이터 -> NavigationPath (enum으로 관리 가능)
    @State var stack = NavigationPath()
    
    var body: some View {
        
        // Link -> Destination으로 화면이동 정보가 쏴질 때
        // 자동으로 stack에 쌓아둠
        NavigationStack(path: $stack, root: {
            NavigationLink("Go to Child View", value: "10")
                .navigationDestination(for: String.self) { value in
                    VStack {
                        NavigationLink("Go to Child's Child View", value: "20")
                        
                        Text("Child Number : \(value)")
                            .foregroundStyle(Color.random)
                        
                        Button("Back to Parent") {
                            stack.removeLast()
                        }
                        
                        Button("Back to Root") {
                            stack = .init()
                        }
                    }
                }
        })
    }
}

#Preview {
    NavigationView2()
}
