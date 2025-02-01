import SwiftUI

struct HitTestView: View {
    
    @State var isFavorite = false
    
    var body: some View {
        // overlay로 버튼 올리면 탭 이벤트가 뺏기나?
        // 둘다 잘됨
        Rectangle()
            .foregroundStyle(Color.purple)
            .frame(width: 200, height: 200)
            .onTapGesture {
                print("@@@ Rectangle 1 tapped !")
            }
            .overlay(alignment: .topTrailing) {
                Button {
                    isFavorite.toggle()
                } label: {
                    Image(systemName: isFavorite ? "star.fill" : "star")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                }
                .offset(x: -20, y: 20)
            }
        
        ZStack {
            Rectangle()
                .foregroundStyle(Color.purple)
                .frame(width: 200, height: 200)
                .onTapGesture {
                    print("@@@ Rectangle 2 tapped !")
                }
            
            Button {
                isFavorite.toggle()
            } label: {
                Image(systemName: isFavorite ? "star.fill" : "star")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
            }
        }
        
        // MARK: - FavoriteButton
        FavoriteButton(
            handler: {
                isFavorite.toggle()
            }, isFavorite: $isFavorite
        )
        
        // FIXME: 또 다른 문제
        // image 바깥의 touchArea 탭할 때
        // FavoriteButton 대신 Rectangle이 이벤트를 받음;
        // 근데 이건 일반 Button도 동일하게 발생하는 문제임;;
        Rectangle()
            .foregroundStyle(Color.purple)
            .frame(width: 100, height: 100)
            .onTapGesture {
                print("@@@ Rectangle 2-1 tapped !")
            }
            .overlay(alignment: .topTrailing) {
                FavoriteButton(
                    handler: {
                        isFavorite.toggle()
                    }, isFavorite: $isFavorite
                )
                .offset(x: -20, y: 20)
            }
        
        ZStack {
            Rectangle()
                .foregroundStyle(Color.purple)
                .frame(width: 100, height: 100)
                .onTapGesture {
                    print("@@@ Rectangle 2-2 tapped !")
                }
            
            FavoriteButton(
                handler: {
                    isFavorite.toggle()
                }, isFavorite: $isFavorite
            )
        }
        
    }
}

#Preview {
    HitTestView()
}
