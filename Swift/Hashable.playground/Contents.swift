import UIKit

/*
 Identifiable, Equatable, Hashable
 */

// 구조체가 Identifiable 하려면
struct Person1: Identifiable {
    var id: UUID // Hashable한 id 값이 필요
    var name: String
    var number: String?
}

// 구조체가 Equatable 채택 시
// 자동완성 시켜줌 (Automatic Synthesis)
struct Person2: Equatable {
    var id: UUID
    var name: String
    var number: String?
}
let person1 = Person2(id: UUID(), name: "1")
let person2 = Person2(id: UUID(), name: "2")
print(person1 == person2) // false



// 클래스는 Identifiable 채택 시
// ObjectIdentifier에 의해 자동으로 id가 지정됨 (참조값 의미할듯)
class Person3: Identifiable {
//    var id: UUID // 필수 아님
    var name: String
    var number: String?
    
    init(name: String, number: String? = nil) {
        self.name = name
        self.number = number
    }
}
let person3 = Person3(name: "3")
let ref3 = person3
let person3else = Person3(name: "3")
print(person3.id == ref3.id) // true
print(person3 === ref3) // true

print(person3.id == person3else.id) // false - 참조가 다르니깐

// 클래스도 Equatable 자동 채택은 아님
// Equatable 채택하면 자동완성 시켜줌 (모든 프로퍼티가 같으면 같다)
print("isEquatable", person3 is any Equatable) // false

class Person4: Equatable {
    var name: String
    var number: String?
    
    init(name: String, number: String? = nil) {
        self.name = name
        self.number = number
    }
    
    // 구조체와 달리 자동완성 안시켜줌
    static func == (lhs: Person4, rhs: Person4) -> Bool {
        return lhs.name == rhs.name
    }
}



// 연관값 없으면 Hashable 자동 채택함
enum PersonEnum {
    case korean
    case american
}
let korean = PersonEnum.korean
print(korean.hashValue) // 랜덤 Int값

protocol Handlable {
    var blah: CGFloat { get }
}

print(korean is any Hashable)  // true
print(korean is any Equatable) // true
print(korean is any Handlable) // false

enum PersonEnum2: Hashable {
    case korean
    case american
}
let korean2 = PersonEnum2.korean
print(korean2.hashValue) // korean과 hash값이 같음 주의 (내용이 똑같아서)

// 연관값 있는데 Hashable 준수하려면 직접 구현 필요
//enum PersonEnum2: Hashable {
//    case korean(age: Person)
//    case american
//    
//    static func == (lhs: PersonEnum2, rhs: PersonEnum2) -> Bool {
//        <#code#>
//    }
//}


// 구조체가 Hashable 채택하면
// 모든 저장 프로퍼티가 Hashable하면 자동완성
struct Building: Hashable {
    let name: String
    let address: String
}

// 열거형이 Hashable 채택하면
// 연관값 없거나, 모든 연관값이 Hashable 하면 자동완성
enum BuildingEnum: Hashable {
    case korean
    case american
}
enum BuildingEnum2: Hashable {
    case korean(age: Int)
    case american
}

// 아니면 직접 구현해야함
enum BuildingEnum3: Hashable {
    case korean(person: Person2)
    case american(person: Person2)
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .korean(let person):
            hasher.combine(person.id) // Person2 프로퍼티 중에 hashable한 값을 넣어야함
            hasher.combine(person.name)
        case .american(let person):
            hasher.combine(person.id)
        }
    }
}
