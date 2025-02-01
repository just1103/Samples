import SwiftUI

struct ImageView: View {
    
    var body: some View {
        Image(systemName: "star.fill")
            .frame(width: 50, height: 50)
        
        Image(systemName: "star.fill")
            .frame(width: 100, height: 100) // resizable 없으면 frame 적용 안됨
        
        Image(systemName: "star.fill")
            .frame(width: 50, height: 50)
            .font(.largeTitle) // resizable 없어도 시스템 폰트는 적용됨
        
        Image(systemName: "star.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 50, height: 50)
        
        Image(systemName: "star.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100)
        
        Image(systemName: "star.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100)
            .font(.largeTitle) // resizable 있으면 시스템 폰트 적용 안됨
    }
}

#Preview {
    ImageView()
}

