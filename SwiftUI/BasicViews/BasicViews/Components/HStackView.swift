import SwiftUI

struct HStackView: View {
    
    var body: some View {
        HStack {
            Image(systemName: "person")
            
            Text("Apple Cider ABCDE FGHIJK 12")
                .foregroundStyle(Color.red)
                .layoutPriority(2)
            
            Text("iOS Developer")
                .foregroundStyle(Color.green)
                .layoutPriority(1)
            
            Text("Online")
                .foregroundStyle(Color.gray)
        }
        .lineLimit(1)
    }
}

#Preview {
    HStackView()
}
