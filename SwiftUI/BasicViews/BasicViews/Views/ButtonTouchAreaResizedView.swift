import SwiftUI

// touchArea 크기를 줄이고 싶다면?
// ref: https://medium.com/arcush-tech/how-to-increase-a-swiftui-view-tap-area-without-sacrificing-the-layout-1d9e7c9d0dbf

struct ButtonTouchAreaResizedView: View {
    
    @State var isFavorite = false
    
    var body: some View {
        
        // default로 padding 20 만큼 touchArea가 넓음
        Button {
            isFavorite.toggle()
        } label: {
            Image(systemName: isFavorite ? "square.fill" : "square")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(Color.brown)
                .frame(width: 100, height: 100)
        }
        .frame(width: 120, height: 120)
        .background(Color.yellow)
        .frame(width: 140, height: 140)
        .background(Color.green)
//        .contentShape(Rectangle().size(width: 105, height: 105)) // touchArea 모양만 조정됨 (size는 안됨)
        .padding(.bottom, 50)
        
        Button {
            isFavorite.toggle()
        } label: {
            Image(systemName: isFavorite ? "square.fill" : "square")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(Color.brown)
                .frame(width: 100, height: 100)
        }
        .frame(width: 50, height: 50) // yellow bg만 변경됨
        .background(Color.yellow)
        .padding(.bottom, 50)
        
        Button {
            isFavorite.toggle()
        } label: {
            Image(systemName: isFavorite ? "square.fill" : "square")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(Color.brown)
                .frame(width: 100, height: 100)
        }
        .frame(width: 120, height: 120)
        .background(Color.yellow)
        .frame(width: 140, height: 140)
        .background(Color.green)
        .contentShape(Circle().size(width: 100, height: 100)) // ???: 오른/아래만 touchArea 작아짐
        .overlay(
            Circle()
                .stroke(Color.red, lineWidth: 1)
                .frame(width: 100, height: 100) // 터치 가능한 영역 표시
        )

        Button {
            isFavorite.toggle()
        } label: {
            Image(systemName: isFavorite ? "square.fill" : "square")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(Color.brown)
                .frame(width: 100, height: 100)
        }
        .modifier(TappablePadding(
            insets: .init(top: 50, leading: 50, bottom: 50, trailing: 50),
            onTap: {
                isFavorite.toggle()
            }))

    }
}

#Preview {
    ButtonTouchAreaResizedView()
}

// touch area 넓히는 것만 가능
struct TappablePadding: ViewModifier {
  let insets: EdgeInsets
  let onTap: () -> Void
  
  func body(content: Content) -> some View {
    content
      .padding(insets)
      .contentShape(Rectangle())
      .onTapGesture {
        onTap()
      }
      .padding(insets.inverted)
  }
}

extension View {
  func tappablePadding(_ insets: EdgeInsets, onTap: @escaping () -> Void) -> some View {
    self.modifier(TappablePadding(insets: insets, onTap: onTap))
  }
}

extension EdgeInsets {
  var inverted: EdgeInsets {
    .init(top: -top, leading: -leading, bottom: -bottom, trailing: -trailing)
  }
}
