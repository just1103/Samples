import SwiftUI

struct LabelView: View {
    
    var body: some View {
        Label("Snow", systemImage: "snow")
        
        Label("Snow", systemImage: "snow")
            .labelStyle(.titleOnly)
        
        Label("Lightning", systemImage: "bolt.fill")
            .labelStyle(.titleAndIcon)
        
        VStack {
            Label("Rain", systemImage: "cloud.rain")
            Label("Sun", systemImage: "sun.max")
        }
        .labelStyle(.iconOnly)
        
        Label {
            Text("AppleCider")
                .font(.body)
                .foregroundColor(.primary)
            Text("Dev")
                .font(.subheadline)
                .foregroundColor(.secondary)
        } icon: {
            Circle()
                .fill(.green)
                .frame(width: 44, height: 44, alignment: .center)
                .overlay(Text("KR"))
        }
        
        // title, icon 모두 View 타입이면 됨
        // 그래서 Button도 들어갈 수 있음
        Label {
            Button("AppleCider") {}
        } icon: {
            Circle()
                .fill(.orange)
                .frame(width: 44, height: 44, alignment: .bottom)
                .overlay(Text("KR"))
        }
    }
}

#Preview {
    LabelView()
}
