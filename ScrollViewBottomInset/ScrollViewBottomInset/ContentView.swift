import SwiftUI
import Combine

struct ContentView: View {
    
    @ObservedObject var keyboardManager = KeyboardManager()
    @FocusState var isFocused: Bool
    @State var text: String = ""
    
    @State var bottomInset: CGFloat = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Rectangle()
                    .foregroundStyle(Color.yellow)
                    .frame(height: 300)
                
                TextField("입력해봐요", text: $text, axis: .vertical)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 50)
                    .focused($isFocused)
                    .background(Color.green)

                Spacer()
            }
            .background(Color.gray)
//            .contentMargins(.bottom, 30, for: .scrollContent) // x
            .padding(.bottom, bottomInset) // 키보드 높이만큼 패딩 추가
            .background(Color.purple)
        }
        .background(Color.blue)
        .contentMargins(.horizontal, 24, for: .scrollContent)
//        .contentMargins(.bottom, bottomInset, for: .scrollContent) // x
//        .padding(.bottom, bottomInset) // x
//        .safeAreaInset(edge: .bottom, content: { // x
//            Rectangle()
//                .foregroundStyle(Color.purple)
//                .frame(height: bottomInset)
//        })
        .background(Color.mint)
        .onReceive(keyboardManager.$keyboardHeight) { height in
            print("@@@ inset 넣을게 ...", height)
            self.bottomInset = height
        }
    }
}

#Preview {
    ContentView()
}
