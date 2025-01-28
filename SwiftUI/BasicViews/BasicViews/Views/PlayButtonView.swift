import SwiftUI

// ref: https://sujinnaljin.medium.com/swiftui-view를-redraw-하는-조건은-어떻게-될까-db3d7551df2

struct PlayButtonView: View {
    
    // Button의 dependency (view에 변경을 줄 수 있는 input 값)가 변경될 때마다
    // body를 호출하여 뷰를 다시 렌더링함
    @State private var isPlaying: Bool = false
    
    var body: some View {
        Button(isPlaying ? "Pause" : "Play") {
            isPlaying.toggle()
        }
        .foregroundStyle(Color.white)
        .padding()
        .background(Color.random) // 버튼 탭할 때마다 색 변경됨
        
        // body가 호출되어도 변경사항이 없으면 redraw를 안할 수 있음
        Button("Fixed Title") {
        }
        .foregroundStyle(Color.white)
        .padding()
//        .background(Color.random) // body 호출될 때마다 색 변경됨
        .background(Color.green) // !!!: body 호출되어도 색 변경 안됨
        
        // view를 쪼개는 것이 유리함
        CustomButton(title: "Custom Button")
            .foregroundStyle(Color.white)
//            .background(Color.random) // !!!: body 호출될 때마다 색 변경됨
        
        CustomButton(title: isPlaying ? "Pause" : "Play") // body 호출될 때마다 색 변경됨
            .foregroundStyle(Color.white)
    }
}

struct CustomButton: View {
    
    var title: String
    
    // !!!: 상위 뷰의 body 호출되어도 색 변경 안됨 (title 변경 없다면)
    var body: some View {
        Text(title)
            .padding()
            .background(Color.random)
    }
}

#Preview {
    PlayButtonView()
}
