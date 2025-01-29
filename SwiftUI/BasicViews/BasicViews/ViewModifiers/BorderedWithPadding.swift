import SwiftUI

struct BorderedView: View {
    
    var body: some View {
        Text("Custom Modifider")
            .modifier(BorderedWithPadding()) // 1
        
        Button("Custom Modifider Button") { }
            .modifier(BorderedWithPadding())
        
        Image(systemName: "star.fill")
            .modifier(BorderedWithPadding())
        
        Image(systemName: "star.fill")
            .borderedWithPadding() // 2
        
        Image(systemName: "star.fill")
            .borderedWithPadding3() // 3
        
        BorderedWithPadding4(content: { // 4
            Image(systemName: "star.fill")
        })
    }
}

// 1. custom viewModifier 활용
struct BorderedWithPadding: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding()
//            .foregroundStyle(.purple) // content만 적용
            .overlay {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(lineWidth: 3)
//                    .foregroundStyle(.purple) // border만 적용
            }
            .foregroundStyle(.purple) // content + border 모두 적용
    }
}

// 2. view extension으로 viewModifier를 쉽게 사용
extension View {
    func borderedWithPadding() -> some View {
        modifier(BorderedWithPadding())
    }
}

// 3. view extension으로 view 자체를 변경
extension View {
    func borderedWithPadding3() -> some View {
        self
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(lineWidth: 3)
            }
            .foregroundStyle(.purple)
    }
}

// 4. View 타입을 생성자 주입 받아 꾸며주는 custom view 정의
struct BorderedWithPadding4<Content: View>: View {
    
    var content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(lineWidth: 3)
            }
            .foregroundStyle(.purple)
    }
}

#Preview {
    BorderedView()
}
