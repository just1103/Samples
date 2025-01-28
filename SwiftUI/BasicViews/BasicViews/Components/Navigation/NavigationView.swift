import SwiftUI

struct NavigationView: View {
    
    var body: some View {
        
        // 구조 참고
        NavigationStack {
  
            NavigationLink("Go to Child View", value: "10")
                .navigationDestination(for: String.self) { value in // Hierarchy가 이상하긴 한데.. NavigationStack 내부에 배치하면 잘 동작함 (Link -> Destination 방향으로 쏴주는거라서 그런듯?)
                    ChildView(value: value)
                }
            
            NavigationLink("Go to Child View", value: "20")

            NavigationLink(value: "30", label: {
                Label("Snow", systemImage: "snow")
                    .background(Color.random)
            })
            
            NavigationLink(value: "40", label: {
                Label("Lightning", systemImage: "bolt.fill")
                    .background(Color.random)
            })
//            .navigationDestination(for: String.self) { value in // 여기도 가능
//                ChildView(value: value)
//            }
        }
//        .navigationDestination(for: String.self) { value in // 여기는 안됨 (NavigationStack 밖)
//            ChildView(value: value)
//        }
    }
}

extension NavigationView {
    
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
    NavigationView()
}
