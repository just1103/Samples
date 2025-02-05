import SwiftUI

// ref:
// https://medium.com/@Jager-yoo/swiftui-list-%EC%99%80-foreach-%EC%9D%98-%EB%B0%98%EB%B3%B5-%EB%B3%80%EC%88%98%EB%A5%BC-%EC%88%98%EC%A0%95-%EA%B0%80%EB%8A%A5%ED%95%98%EA%B2%8C-%EB%A7%8C%EB%93%A4%EA%B8%B0-7e50d1d57a42

// https://chance-lab.tistory.com/36

// item 1개가 toggle 될 때, 왜 전체 List가 Redraw 되나?
// 해당 itemView만 redraw 되도록 성능 개선한다면?

// +) id 자체를 변경시키면 어떻게 되지?
// -> InsertDeleteListView

struct Coffee: Identifiable {
//struct Coffee: Identifiable, Equatable { // 안됨
    let id = UUID()
    let name: String
    var isFavorited: Bool = false
    
    static func == (lhs: Coffee, rhs: Coffee) -> Bool {
        lhs.id == rhs.id
        && lhs.isFavorited == rhs.isFavorited
    }
}

struct CoffeeItemView: View, Equatable { // 결론 : View가 Equatable을 채택해서 == 구현해야함 (!)
    @Binding var coffee: Coffee
    
    var body: some View {
        HStack {
            Text(coffee.name)
                .background(Color.random) // redraw 체커
            
            Image(systemName: coffee.isFavorited ? "heart.fill" : "heart")
                .foregroundColor(.red)
                .onTapGesture {
                    coffee.isFavorited.toggle()
                }
        }
        .padding(.vertical)
    }
    
    static func == (lhs: CoffeeItemView, rhs: CoffeeItemView) -> Bool {
//        lhs.coffee.id == rhs.coffee.id
//        && lhs.coffee.isFavorited == rhs.coffee.isFavorited // 된다!!!!!
        
        lhs.coffee == rhs.coffee // 위 로직을 coffee 모델 내부에서 비교하도록 바꾼거
    }
}

struct CoffeeListView: View {
    @State private var coffees: [Coffee] = [
        .init(name: "아메리카노"),
        .init(name: "카페 라떼"),
        .init(name: "에스프레소"),
        .init(name: "카푸치노"),
    ]
    
    var body: some View {
        ForEach($coffees, id: \.id) { $coffee in // 둘다 $을 붙여서 isFavorited 수정 가능하도록 함
            CoffeeItemView(coffee: $coffee)
        }
    }
}
