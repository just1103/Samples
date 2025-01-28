import SwiftUI

struct VScrollView: View {
    
    var body: some View {
        ScrollView(
            .vertical,
            showsIndicators: true,
            content: {
                VStack(alignment: .leading) {
                    ForEach(0..<50) {
                        Text("Row \($0)")
                            .padding()
                            .background(Color.random)
                    }
                }
            }
        )
    }
}

#Preview {
    VScrollView()
}
