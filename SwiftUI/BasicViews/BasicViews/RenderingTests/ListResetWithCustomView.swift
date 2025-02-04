import SwiftUI

struct NumbItem: Hashable {
//struct NumbItem: Identifiable {
    let id = UUID()
    var number: Int
}

// ListResetView 참고
// DataSource가 변경될 때 목록은 어떻게 Redraw 될까?
// 목록 아이템뷰로 커스텀뷰를 쓰면? - 구조체 값 전체를 넘겨도 LazyVStack 목록 갱신안됨! 굿!
// 결론: View 분리하자! 그럼 List 대신 LazyVStack 써도.. 될듯..?
// reuse 많이 해야하는 큰 데이터면 다르겠지만..

struct CustomTextView: View {
//    @Binding var text: Int
    @Binding var item: NumbItem
    
    var body: some View {
//        Text("\(text)")
        Text("\(item)")
            .frame(maxWidth: .infinity)
            .padding(.vertical, 5)
            .background(Color.random)
    }
}

struct ListResetWithCustomView: View {
//    @State private var numbers = Array(0..<10)
    @State private var numbers = (0..<10_000).map { NumbItem(number: $0) }
    
    var body: some View {
        
        // 1. List
////        List($numbers, id: \.self) { number in
//        List($numbers, id: \.id) { item in
//            CustomTextView(item: item)
//        }
//        .listStyle(.plain)
//        .background(Color.random)
//        .refreshable {
//            refreshData()
//        }
        
        // 2. LazyVStack
        ScrollView {
              LazyVStack(spacing: 10) {
//                  ForEach($numbers, id: \.self) { number in
                  ForEach($numbers, id: \.id) { item in
                      CustomTextView(item: item)
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
//        numbers[0] = 0 // 안바뀜
//        numbers = Array(0..<10).shuffled() // 전체 변경
//        numbers += [Int.random(in: 20..<100)] // 전체 변경
//        numbers[0] = 1 // 전체 변경
        
        // 테스트-2. List & numbers == NumberItem
//        numbers[0].number = 0 // 안바뀜
//        numbers[0].number = Int.random(in: 10..<100) // 전체 변경
        
        // 테스트-3. LazyVStack & numbers == 0..<10
        // 테스트-1과 동일함
//        numbers = Array(0..<10)
//        numbers = Array(0..<10).shuffled()
//        numbers += [Int.random(in: 10..<100)]
//        numbers[0] = Int.random(in: 10..<100)
        
        // 테스트-4. LazyVStack & numbers == NumberItem
        numbers[0].number = 0 // ListResetView와 달리 안바뀜 (굿!!!)
//        numbers[0].number = Int.random(in: 10..<100) // 전체 변경
    }
}

#Preview {
    ListResetWithCustomView()
}
