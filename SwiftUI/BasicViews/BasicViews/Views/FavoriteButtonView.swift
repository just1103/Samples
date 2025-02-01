import SwiftUI

// star image : 16x16
// touch area : 32x32

// system default touch area : 10+16+10 = 36
// system default padding : 10 <- 이게 ButtonSize 비율에 따라 달라질수도?

// label size x = 32 - 2*10 = 12
// label을 12로 해도 touchArea가 32 보다 살짝 큼
// label 10으로 하면 딱 맞음

struct FavoriteButtonView: View {
    
    @State var isFavorite = false
    
    var body: some View {
        FavoriteButton(
            handler: {
                isFavorite.toggle()
            },
            isFavorite: $isFavorite
        )
    }
}

struct FavoriteButton: View {
    
    let handler: () -> Void
    @Binding var isFavorite: Bool
    
    var body: some View {
        
        // ButtonTouchAreaResizedView 참고
        ZStack {
            
            Button {
                handler()
            } label: {
                Color.clear
                    .frame(width: 10, height: 10) // 실제 크기보다 줄이기 - 잘 동작하는 사이즈
//                    .frame(width: 12, height: 12) // 실제 크기보다 줄이기 - 계산한 사이즈 
                
//                Rectangle() // Rectangle도 동일
//                    .frame(width: 12, height: 12)
//                    .foregroundStyle(Color.pink)
            }
            .frame(width: 16, height: 16)
            .background(Color.yellow)
            .frame(width: 32, height: 32)
            .background(Color.blue)
            
            Image(systemName: isFavorite ? "star.fill" : "star")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 16, height: 16) // 원하는 크기
                .allowsHitTesting(false) // tap gesture를 Button에 전달
        }
    }
}

#Preview {
    FavoriteButtonView()
}
