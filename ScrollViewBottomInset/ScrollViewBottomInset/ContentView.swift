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
                        .onChange(of: text) { _ in
                            // !!!: When text changes, scroll to the end if needed
                            if isFocused {
                                DispatchQueue.main.async {
                                    proxy.scrollTo("bottom", anchor: .bottom)
                                }
                            }
                        }

                    Spacer()
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
                self.bottomInset = height
            }
            
        }
        
    }
}

#Preview {
    ContentView()
}
