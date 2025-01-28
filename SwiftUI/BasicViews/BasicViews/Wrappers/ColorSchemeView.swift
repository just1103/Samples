import SwiftUI

struct ColorSchemeView: View {
    // @Environment
    // 시스템 설정값을 keyPath로 받아옴
    // 뷰 초기화 시점에 값이 초기화됨
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Text("Hello")
            .foregroundStyle(colorScheme == .dark ? .purple : .yellow)
            .background(Color.random)
    }
}
