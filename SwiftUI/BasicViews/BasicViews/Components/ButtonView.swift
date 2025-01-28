import SwiftUI

struct ButtonView: View {
    
    var body: some View {
        Button(action: {
            print("Default button tapped")
        }) {
            Text("Default Button")
        }
        .background(Color.yellow)
        .padding()
        .background(Color.red)
        
        // 크기 고정
        Button(action: {
            print("Fixed size button tapped")
        }) {
            Text("Fixed Size Button")
                .frame(width: 200, height: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        
        // 패딩 설정
        Button(action: {
            print("Padded button tapped")
        }) {
            Text("Padded Button")
                .padding(20)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(15)
        }
        
        // foregroundColor 참고
        Button(action: {
            print("Icon button tapped")
        }) {
            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                Text("Title")
                    .foregroundColor(.green)
                Text("SubText")
            }
            .padding()
            .frame(width: 250, height: 60) // 명시적인 크기 설정
            .background(Color.purple)
            .foregroundColor(.white) // foregroundColor 설정 안한 컴포넌트만 적용됨
            .cornerRadius(20)
        }
        
        // 이미지 아이콘만 사용
        Button(action: {
            print("Icon button tapped")
        }) {
            HStack {
                Image(systemName: "star.fill")
            }
            .padding() // <- 크기 이렇게 키우는게 일반적
            .background(Color.purple)
            .cornerRadius(20)
        }
        
        Button(action: {
            print("Icon button tapped")
        }) {
            HStack {
                Image(systemName: "star.fill")
                    .frame(width: 100, height: 100) // 여기줘도 아래와 동일함
            }
//            .frame(width: 100, height: 100)
            .background(Color.purple)
            .cornerRadius(20)
        }
        
        Button(action: {
            print("Icon button tapped")
        }) {
            HStack {
                Image(systemName: "star.fill")
                    .resizable() // 이게 있어야 이미지 늘어남 (!)
                    .aspectRatio(contentMode: .fit) // 비율 유지
//                    .frame(width: 60, height: 60)
                    .padding()
            }
            .frame(width: 100, height: 100) // 대신 이게 없으면 무한정 커짐 (resizable 때문)
            .background(Color.purple)
            .cornerRadius(20)
        }
    }
}

#Preview {
    ButtonView()
}
