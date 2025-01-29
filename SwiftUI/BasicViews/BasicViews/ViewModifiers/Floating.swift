import SwiftUI

struct FloatingButtonView: View {
    
    var body: some View {
        Rectangle()
            .fill(Color.gray)
            .floating(action: {
                print("@@@ Floating Tapped !")
            })
    }
}

struct Floating: ViewModifier {
    
    let action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    func body(content: Content) -> some View {
        // content = floating 버튼 아래에 깔리는 뷰
        // ZStack을 분리해서 코드 가독성 개선됨 (!)
        ZStack {
            content
         
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button(action: action) {
                        // 버튼 Label도 외부에서 주입받도록 개선하면 유용할듯
                        Image(systemName: "pencil.circle.fill")
                            .resizable()
                            .foregroundColor(.purple)
                            .frame(width: 100, height: 100)
                    }
                }
                .padding(40)
            }
            
        }
    }
}

extension View {
    func floating(action: @escaping () -> Void) -> some View {
        modifier(Floating(action: action))
    }
}

#Preview {
    FloatingButtonView()
}
