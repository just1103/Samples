import SwiftUI

struct CardItemView: View {
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Rectangle()
                    .frame(width: 300, height: 300)
                    .foregroundColor(.blue)
                
                Rectangle()
                    .frame(width: 200, height: 200)
                    .foregroundColor(.pink)
                    .padding(70)
                
                Text("Hello, SwiftUI!")
//                    .padding(.horizontal, 20) // 원했던게 아님 (글자-bg 간의 간격임)
                    .background(Color.yellow)
                    .padding(.bottom, 30)
//                    .offset(y: -30) // 이것도 가능
                    
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray.opacity(0.2))
    }
    
//    var body: some View {
//        ZStack {
//            RoundedRectangle(cornerRadius: 12)
//                .foregroundStyle(Color.gray)
//                .aspectRatio(1.0, contentMode: .fit)
//                .background(Color.yellow)
//                .frame(width: 400, height: 400)
//            
//            Rectangle()
//                .fill(.green)
//                .frame(width: 300, height: 300)
//                .padding(.vertical, 100) // 이게 있으면 Text가 왜 밑으로 밀려나지?
//        }
//        .overlay(alignment: .bottom) {
//            Text("안녕하세요. 네모의 꿈입니다.")
//                .font(.title)
//                .lineLimit(2)
//                .minimumScaleFactor(0.8)
//                .offset(y: -10)
//        }
//    }
}

#Preview {
    CardItemView()
}

