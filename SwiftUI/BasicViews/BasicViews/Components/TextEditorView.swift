import SwiftUI

struct Memo: Hashable {
    var title: String
    var content: String
    var date: Date
    var id = UUID()
}

class MemoViewModel: ObservableObject {
    @Published var memo: Memo
    
    init(memo: Memo) {
        self.memo = memo
    }
}

struct TextEditorView: View {
    @ObservedObject private var memoViewModel: MemoViewModel
    
    init(memoViewModel: MemoViewModel) {
        self.memoViewModel = memoViewModel
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $memoViewModel.memo.content)
                .font(.system(size: 20))
            
            // TextEditor에는 placeholder가 없어서
            // 별도의 Text를 올려서 표시
            if memoViewModel.memo.content.isEmpty {
                Text("메모를 입력하세요.")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                    .allowsHitTesting(false) // TextEditor에게 탭 이벤트를 전달
                    .padding(.top, 10) // FIXME: padding 맞춰주는거 번거로움;
                    .padding(.leading, 5)
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    TextEditorView(memoViewModel: .init(memo: .init(
        title: "title",
        content: "",
//        content: "어쩌구 저쩌구 어쩌구 저쩌구 어쩌구 저쩌구 어쩌구 저쩌구 어쩌구 저쩌구 어쩌구 저쩌구 어쩌구 저쩌구 어쩌구 저쩌구 어쩌구 저쩌구 어쩌구 저쩌구 어쩌구 저쩌구 어쩌구 저쩌구 어쩌구 저쩌구 어쩌구 저쩌구 어쩌구 저쩌구",
        date: .now
    )))
    .padding(.top, 100)
}
