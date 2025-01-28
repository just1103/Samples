import SwiftUI

class Contact: ObservableObject {
    @Published var name: String
    @Published var age: Int

    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    func agedUp() {
        age += 1
    }
}

struct ObservableObjectView: View {
    
    // @ObservedObject 또는 @StateObject가 있어야 변화를 캐치하고, 뷰에 반영함
    @ObservedObject var hyo = Contact(name: "Hyo", age: 30)
    @ObservedObject var ping = Contact(name: "Ping", age: 20)
    
    // ObservableObject 클래스 인스턴스를 @State에 담으면, 변화 캐치를 못함
    // !!!: Contact 객체의 변화를 감지하려면 @ObservedObject 또는 @StateObject로 선언해야 함
//    @State var pong = Contact(name: "Pong", age: 10)
//    let pong = Contact(name: "Pong", age: 10)
    @StateObject var pong = Contact(name: "Pong", age: 10)
    
    var body: some View {
        
        // 1
        Text("\(hyo.name) \(hyo.age)")
            .background(Color.random)
        Text("\(hyo.name)") // 값은 똑같지만 Contact 중 하나라도 변경되면 redraw 함 (별도 View로 분리하지 않으면 비효율적)
            .background(Color.random)
        Text("\(hyo.age)")
            .background(Color.random)
        Button("Hyo Age +") {
            // hyo/ping 인스턴스가 let으로 선언되어 있으면? Text에 바로 반영되지 않음
            // @ObservedObject가 있어야 반영됨
            hyo.agedUp()
        }
        .background(Color.random)
        .padding(.bottom, 20)
        
        // 2
        Text("\(ping.name) \(ping.age)")
            .background(Color.random)
        Button("Ping Age +") {
            ping.agedUp()
        }
        .background(Color.random)
        .padding(.bottom, 20)
        
        // 3
        Text("\(pong.name) \(pong.age)")
            .background(Color.random)
        Button("Pong Age +") {
            // @State이든 아니든, 바로 반영 안됨 (!)
            // 다른 뷰의 값 변경으로 인해 body가 재호출될 때만 업뎃됨
            pong.agedUp()
        }
        .background(Color.random)
        .padding(.bottom, 20)
        
//        CustomView(contact: $pong) // @State일 때만 넘길 수 있음
    }
}

extension ObservableObjectView {
    
    struct CustomView: View {
        @Binding var contact: Contact
        
        var body: some View {
            Text("\(contact.name) \(contact.age)")
                .background(Color.random)
            Button("Age +") {
                // @State pong의 값에 영향 없음
                contact.agedUp()
            }
            .background(Color.random)
        }
    }
}
