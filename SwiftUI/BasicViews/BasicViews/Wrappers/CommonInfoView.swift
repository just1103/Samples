import SwiftUI

class CommonInfo: ObservableObject {
    @Published var userAge: Int = 30
}

struct CommonInfoView: View {
    
    // @EnvironmentObject
    // 앱 전역에서 공통으로 사용할 데이터
    // 최상위 뷰가 데이터를 들고 있고, 하위 뷰로 데이터를 내려주는 방식으로 관리하면 편함
    @EnvironmentObject var commonInfo: CommonInfo
    
    var body: some View {
        // 변경되면 뷰에 바로 반영됨 (!)
        Button("Current Age: \(commonInfo.userAge)") {
            commonInfo.userAge += 1
        }
    }
}
