import SwiftUI

enum NavigationDestination: Hashable {
}

struct HitTestView: View {
    
    @State var isFavorite = false
    @State var path: [NavigationDestination] = []
    
    var body: some View {
        
        NavigationStack(path: $path) {
            
            // overlay로 버튼 올리면 탭 이벤트가 뺏기나?
            // 둘다 잘됨
            Rectangle()
                .foregroundStyle(Color.purple)
                .frame(width: 100, height: 100)
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
                            .frame(width: 50, height: 50)
                    }
                    .offset(x: -10, y: 10)
                }
            
            ZStack {
                Rectangle()
                    .foregroundStyle(Color.purple)
                    .frame(width: 100, height: 100)
                    .onTapGesture {
                        print("@@@ Rectangle 2 tapped !")
                    }
                
                Button {
                    isFavorite.toggle()
                } label: {
                    Image(systemName: isFavorite ? "star.fill" : "star")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                }
            }
            
            // MARK: - FavoriteButton on Button
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
            
            // MARK: - FavoriteButton on List
            ScrollView {
                LazyHGrid(
                    rows:  [
                        GridItem(.fixed(100)),
                    ],
                    alignment: .center,
                    spacing: 8
                ) {
                    ForEach(0..<3, id: \.self) { item in
                        NavigationLink(destination: Text("Detail")) {
                            Rectangle()
                                .fill(Color.gray)
                                .frame(width: 100, height: 100)
                                .overlay(alignment: .topTrailing) {
                                    FavoriteButton(
                                        handler: {
                                            isFavorite.toggle()
                                        }, isFavorite: $isFavorite
                                    )
                                    .offset(x: -10, y: 10)
                                }
                        }
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    HitTestView()
}
