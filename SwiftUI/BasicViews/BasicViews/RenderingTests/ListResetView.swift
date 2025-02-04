import SwiftUI

//struct NumberItem: Identifiable {
struct NumberItem: Hashable {
    let id = UUID()
    var number: Int
}

// DataSource가 변경될 때 목록은 어떻게 Redraw 될까?

struct ListResetView: View {
//    @State private var numbers = Array(0..<10)
    @State private var numbers = (0..<10).map { NumberItem(number: $0) }
    
    var body: some View {
        
        // 1. List
//        List(numbers, id: \.self) { number in
////        List(numbers, id: \.id) { number in
//            Text("\(number)")
//                .frame(maxWidth: .infinity)
//                .padding(.vertical, 5)
//                .background(Color.random)
//        }
//        .listStyle(.plain)
//        .background(Color.random)
//        .refreshable {
//            refreshData()
//        }
        
        // 2. LazyVStack
        ScrollView {
              LazyVStack(spacing: 10) {
//                  ForEach(numbers, id: \.self) { number in
                  ForEach(numbers, id: \.id) { item in
                      Text("\(item.number)") // 이걸 별도 뷰로 파면 안바뀔듯
                          .frame(maxWidth: .infinity)
//                          .frame(maxWidth: .infinity, maxHeight: 50) // 왜 높이 안바껴
                          .padding(.vertical, 5)
                          .background(Color.random)
                  }
              }
              .padding()
          }
          .background(Color.random)
          .refreshable {
              refreshData()
          }
    }
    
    private func refreshData() {
        // 테스트-1. List & numbers == 0..<10
//        numbers = Array(0..<10) // 안바뀜
//        numbers = Array(0..<10).shuffled() // 전체 변경
//        numbers += [Int.random(in: 20..<100)] // 전체 변경 - 마지막 요소만 추가해도
//        numbers[0] = 1 // 전체 변경 - 하나만 바꿔도 전체를 다시 그림
        
        // 테스트-2. List & numbers == NumberItem
//        numbers[0].number = 0 // 안바뀜 (List도 그대로 있음)
//        numbers[0].number = Int.random(in: 10..<100) // 전체 변경 (List도 다시 그려짐) - 하나만 바꿔도 다시 그림 (!)
        
        // 테스트-3. LazyVStack & numbers == 0..<10
        // 테스트-1과 동일함
//        numbers = Array(0..<10_000) // 안바뀜
//        numbers = Array(0..<10).shuffled() // 전체 변경
//        numbers += [Int.random(in: 10..<100)] // 전체 변경
//        numbers[0] = Int.random(in: 10..<100) // 전체 변경
        
        // 테스트-4. LazyVStack & numbers == NumberItem
        numbers[0].number = 0 // 전체 변경 (ScrollView 자체도 다시 그려짐) - List랑 다르네 (!)
        // Text에 item 자체를 넘기면 변경되고, item.number Int값만 넘기면 안바뀜 (!!!)
//        numbers[0].number = Int.random(in: 10..<100) // 전체 변경
        
        // 결론: 성능이 List가 LazyVStack보다 더 좋구나
        // 목록 갱신 시, 데이터 (구조체 타입)가 동일할 때
        // List 자체는 갱신이 안되지만, LazyVStack은 ScrollView 자체가 갱신됨
        // 근데 ScrollView가 갱신되는건 큰 의미는 없음 ㅇㅅㅇ
        // (근데 데이터가 Int Array 일 때랑 왜 다르게 반응하지?)
    }
}

#Preview {
    ListResetView()
}
