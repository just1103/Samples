import SwiftUI

// ref: https://sujinnaljin.medium.com/swiftui-view를-redraw-하는-조건은-어떻게-될까-db3d7551df2

class MyViewModel: ObservableObject {
    
    @Published var firstTitle = "firstTitle"
    @Published var secondTitle = "secondTitle"
    
    func changeFirstTitle() {
        // firstTitle 문자열이 변경될 때만, firstView 색깔만 변경됨
        // secondView에는 영향 없음
        firstTitle = "hello world" + (["!", "?", "@"].randomElement() ?? "#")
    }
}

struct RedrawingTextView: View {

    @ObservedObject var viewModel = MyViewModel()
//    @StateObject var viewModel = MyViewModel()
    @State var thirdTitle = "thirdTitle"

    var body: some View {
        VStack {
            FirstView(text: $viewModel.firstTitle)
                .background(.random)
            
            SecondView(text: $viewModel.secondTitle)
                .background(.random)
            
            ThirdView(text: thirdTitle)
                .background(.random)

            Text(thirdTitle) // 별도 view가 아니므로 항상 색깔 변경됨 
                .background(.random)
            
            Button("Change first title") {
                viewModel.changeFirstTitle()
            }
        }
    }
}

struct FirstView: View {
    
//    let text: String // 이전 값과 다르면 다시 렌더링
    @Binding var text: String // 이전 값과 다르면 다시 렌더링
    
    var body: some View {
        Text(text)
            .background(.random)
    }
}

struct SecondView: View {
    
//    let text: String // 아래와 동일함
    
    // !!!: MyViewModel의 secondTitle이 같으면 렌더링 안함
    // 블로그 내용과 다르게, secondTitle 변경될 때만 렌더링함 (성능 개선?)
    @Binding var text: String
    
    var body: some View {
        Text(text)
            .background(.random)
    }
}

struct ThirdView: View {
    
    let text: String
    
    var body: some View {
        Text(text)
            .background(.random)
    }
}

#Preview {
    RedrawingTextView()
}
