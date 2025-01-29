import SwiftUI

struct AnimatedView: View {
    
    @State private var isSelected = false
    @State private var isBigSnow = false
    
    // scaleEffect : 애니메이션 가능한 특수 프로퍼티 (animatable)
    // 이 값이 변경되면 transaction에 관련 애니메이션이 설정되어있는지 확인함 (스유 메커니즘)
    var body: some View {
        Image(systemName: "cloud.rain")
            .resizable()
            .scaledToFit() // 비율 안깨지도록
            .frame(width: 100)
            .foregroundStyle(Color.random)
            .scaleEffect(isSelected ? 1.5 : 1) // true에서 1.5배 커짐
            .transaction {
                // 여러 애니메이션이 설정되어 있으면 한꺼번에 처리시켜줌 (애니메이션을 재정의)
                $0.animation = .easeInOut(duration: 0.5)
            }
            .onTapGesture {
//                withAnimation(.bouncy) { // 애니메이션 적용
//                withAnimation(.easeInOut(duration: 0.5)) {
                    isSelected.toggle()
//                }
            }
        
        // animation 1/2이 shadow/scaleEffect에 각각 적용되어 있음
        // 주의 - 1번을 지우면 -> 의도치 않게 shadow에도 2번 애니메이션이 들어감
        Image(systemName: "sun.max")
            .resizable()
            .scaledToFit()
            .frame(width: 200)
            .foregroundStyle(Color.random)
            .shadow(color: .yellow.opacity(0.9), radius: isSelected ? 50 : 0)
//            .animation(.linear(duration: 3.0), value: isSelected)
            .scaleEffect(isSelected ? 1.5 : 1)
            .animation(.easeInOut(duration: 2.0), value: isSelected)
            .onTapGesture {
                isSelected.toggle()
            }
        
        Image(systemName: "sun.max")
            .resizable()
            .scaledToFit()
            .frame(width: 100)
            .foregroundStyle(Color.random)
            .shadow(color: .red.opacity(0.9), radius: 50) // 그림자 노출
        
        Image(systemName: "sun.max")
            .resizable()
            .scaledToFit()
            .frame(width: 100)
            .foregroundStyle(Color.random)
            .shadow(color: .red.opacity(0.9), radius: 0) // 그림자 미노출
        
        // ???: 크기 바뀔 때마다 왜 3/4번만 redraw 되지
        Image(systemName: "snow")
            .resizable()
            .scaledToFit()
            .frame(width: 100)
            .foregroundStyle(Color.random)
            .scaleEffect(isBigSnow ? 1.5 : 1)
            .onAppear {
                withAnimation(.spring().repeatForever()) {
                    isBigSnow.toggle()
                }
            }
            .onDisappear {
                isBigSnow = false
            }
    }
}

#Preview {
    AnimatedView()
}

