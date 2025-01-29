import SwiftUI

// ButtonStyle은 ViewModifier의 일종은 아님
// 별도의 protocol

// ButtonStyle : makeBody(configuration:) 구현, 버튼에만 적용 가능
// ViewModifier : body(content:) 구현, 모든 View에 적용 가능 
struct PressedButtonStyle: ButtonStyle {
    
    let textColor: Color
    let bgColor: Color
    let borderColor: Color
    
    init(
        textColor: Color,
        bgColor: Color? = nil,
        borderColor: Color? = nil
    ) {
        self.textColor = textColor
        self.bgColor = bgColor ?? .white
        self.borderColor = borderColor ?? textColor
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 14))
            .foregroundStyle(textColor)
            .frame(maxWidth: .infinity, maxHeight: 40) // width x, maxWidth o
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(bgColor)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(borderColor, lineWidth: 1)
            }
//            .clipShape(RoundedRectangle(cornerRadius: 20)) // 방법-2
            .padding(.horizontal, 15)
            .opacity(configuration.isPressed ? 0.5 : 1) // pressed 되면 흐려지게
    }
}

struct PressedButtonStyleView: View {
    
    var body: some View {
        Button {
        } label: {
            Text("PressedButtonStyle")
        }
        .buttonStyle(PressedButtonStyle(
            textColor: .purple,
            bgColor: .yellow,
            borderColor: .green
        ))
        
        Button {
        } label: {
            Text("PressedButtonStyle")
        }
        .pressedButtonStyle(textColor: .purple)
    }
}

extension Button {
    
    func pressedButtonStyle(
        textColor: Color,
        bgColor: Color? = nil,
        borderColor: Color? = nil
    ) -> some View {
        buttonStyle(PressedButtonStyle(
            textColor: textColor,
            bgColor: bgColor,
            borderColor: borderColor
        ))
    }
}

#Preview {
    PressedButtonStyleView()
}
