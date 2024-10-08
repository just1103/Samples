import SwiftUI
import Combine

struct ContentView: View {
    
    @ObservedObject var keyboardManager = KeyboardManager()
    @FocusState var isFocused: Bool
    @State var text: String = ""
    
    @State var bottomInset: CGFloat = 0
    
    var body: some View {

        ScrollViewReader { proxy in
            
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
                        .id("bottom2") // 이건 계속 숨겨짐
                        .onChange(of: text) { _, _ in
                            // !!!: When text changes, scroll to the end if needed
                            if isFocused {
                                DispatchQueue.main.async {
                                    // FIXME: 전체 텍스트가 화면높이보다 길 때, 텍스트 앞부분 수정할 때는 scroll 시키면 안됨 
                                    proxy.scrollTo("bottom", anchor: .bottom)
                                }
                            }
                        }

                    Spacer() // bottom inset 역할
                        .frame(height: 16)
                        .id("bottom")
                }
                .background(Color.gray)
                .background(Color.purple)
            }
            .background(Color.blue)
            .contentMargins(.horizontal, 24, for: .scrollContent)
    //        .contentMargins(.bottom, bottomInset, for: .scrollContent) // x
    //        .padding(.bottom, bottomInset) // x
    //        .safeAreaPadding(.bottom, bottomInset) // x
    //        .safeAreaInset(edge: .bottom, content: { // x
    //            Rectangle()
    //                .foregroundStyle(Color.purple)
    //                .frame(height: bottomInset)
    //        })
            .background(Color.mint)
            .onReceive(keyboardManager.$keyboardHeight) { height in
                print("@@@ inset 넣을게 ...", height)
                self.bottomInset = height // 주의 - UIKit과 달리 inset으로 해결이 안됨
            }
            
        }
        
    }
}

#Preview {
    ContentView()
}
