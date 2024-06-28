import UIKit

// 1
// OptionSet 프로토콜 채택하고
struct BorderOptions: OptionSet {
    
    // 2
    // 이거 넣어주면 -> Set 관련 operations 쓸 수 있음
    // FixedWidthInteger protocol, such as Int or UInt8
    // *초기화 시 선택지의 bit mask 값을 여기에 저장하는 역할
    let rawValue: Int
    
    // 3
    // 선택지를 만들 때는 static 프로퍼티로 정의함
    // 각각의 rawValue를 설정할 때는 2의 제곱을 넣어줌 (ex. 1, 2, 4, 8, 16)
    static let top = BorderOptions(rawValue: 1 << 0)    // 1 << 0 == 1
    static let left = BorderOptions(rawValue: 1 << 1)   // 1 << 1 == 2
    static let right = BorderOptions(rawValue: 1 << 2)  // 1 << 2 == 4
    static let bottom = BorderOptions(rawValue: 1 << 3) // 1 << 3 == 8
//    static let bottom = BorderOptions(rawValue: 1 << 0) // test (빌드 에러 안남)
    
    // 4
    // 고유의 선택지를 조합하려면? array literal 형태로 만들면 됨
    static let vertical: BorderOptions = BorderOptions([.top, .bottom])
    static let horizontal = BorderOptions(arrayLiteral: .left, .right)
}

// 5
// BorderOptions 인스턴스를 생성하려면
// 위에서 정의한 static 프로퍼티를 할당하면 됨
let singleOption: BorderOptions = .bottom
let multipleOptions: BorderOptions = [.vertical, .horizontal]
let noOptions: BorderOptions = [] // 헷갈림 주의 - 배열이 아니라 Set임

// 6
// set 관련 operations 예시
var options: BorderOptions = []
options.insert(.vertical)
options.contains(.top)    // true
options.contains(.bottom) // true
options.contains(.left)   // false
options.contains(.right)  // false

print(options) 
// BorderOptions(rawValue: 9)
// top(1) + bottom(8) 이라서
