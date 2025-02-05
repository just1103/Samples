import SwiftUI

// https://jierong.dev/2020/05/31/foreach-with-index-in-swiftui.html

// ForEach에게 id는 어떤 의미지?
// 목록 그릴 때, 중복을 판단하는 애임 (성능 최적화를 위한 장치)
// ex. [1, 2, 1, 2] -> 아이템 2개만 생성됨

//struct Coffee2: Identifiable {
struct Coffee2: Hashable {
    let id = UUID()
    let name: String
    var isFavorited: Bool = false
    
    static func == (lhs: Coffee2, rhs: Coffee2) -> Bool {
        lhs.id == rhs.id
        && lhs.isFavorited == rhs.isFavorited
    }
}

struct CoffeeItemView2: View {
//struct CoffeeItemView2: View, Equatable {
    
    @Binding var coffee: Coffee2
    
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
    
    static func == (lhs: CoffeeItemView2, rhs: CoffeeItemView2) -> Bool {
        lhs.coffee == rhs.coffee // 위 로직을 coffee 모델 내부에서 비교하도록 바꾼거
    }
}

struct InsertDeleteListView: View {
    // insert/delete 하면 전체 목록이 갱신되므로 문제 없음
    // 근데 CoffeeItemView2가 Equatable 채택하면,
    // @Binding 때문에 insert/delete 시 잘못된 index item이 toggle 됨 (append/deleteLast는 괜찮음)
    @State private var coffees: [Coffee2] = [
        .init(name: "아메리카노"),
        .init(name: "카페 라떼"),
        .init(name: "에스프레소"),
        .init(name: "카푸치노"),
    ]
    
    var body: some View {
        VStack {
//            ForEach($coffees, id: \.id) { $coffee in // \.id   -> identifiable 필요
            ForEach($coffees, id: \.self) { $coffee in // \.self -> hashable 필요
                CoffeeItemView2(coffee: $coffee)
            }
            
            HStack {
                Button {
                    coffees.append(.init(name: "\(Int.random(in: 0..<100))"))
                } label: {
                    Text("append")
                }
                .padding()
                .background(Color.yellow)
                
                Button {
                    coffees.insert(.init(name: "\(Int.random(in: 0..<100))"), at: 1)
                } label: {
                    Text("insert at 1")

                }
                .padding()
                .background(Color.yellow)
                
                Button {
                    coffees.remove(at: 1)
                } label: {
                    Text("remove at 1")
                }
                .padding()
                .background(Color.yellow)
                
                Button {
                    coffees.removeLast()
                } label: {
                    Text("removeLast")
                }
                .padding()
                .background(Color.yellow)
            }
        }
        
    }
}

#Preview {
    InsertDeleteListView()
}
