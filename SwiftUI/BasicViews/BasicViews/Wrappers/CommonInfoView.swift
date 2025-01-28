import SwiftUI

class CommonInfo: ObservableObject {
    @Published var userAge: Int = 30
}

struct CommonInfoView: View {
    
    // @EnvironmentObject
    // 앱 전역에서 공통으로 공유하는 데이터 (ObservableObject 객체만 가능)
    // 최상위 뷰가 데이터를 들고 있고, 하위 뷰로 데이터를 내려주는 방식으로 관리하면 편함
    @EnvironmentObject var commonInfo: CommonInfo
    
    var body: some View {
        // 변경되면 뷰에 바로 반영됨 (!)
        Button("Current Age: \(commonInfo.userAge)") {
            commonInfo.userAge += 1
        }
        .background(Color.random)
        
        ChildView()
//            .environmentObject(info) // 써주지 않아도 알아서 env로 넘어감 
    }
}

extension CommonInfoView {
    
    struct ChildView: View {
        @EnvironmentObject var commonInfo: CommonInfo
        
        var body: some View {
            Button("Current Age: \(commonInfo.userAge)") {
                commonInfo.userAge += 1
            }
            .background(Color.random)
        }
    }
}
