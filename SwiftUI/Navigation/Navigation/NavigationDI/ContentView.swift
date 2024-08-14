import SwiftUI

struct ContentView: View {
    @StateObject private var container = DIContainer()
    @StateObject private var authViewModel = AuthenticationViewModel()
    
    var body: some View {
        MainTabView()
            .environmentObject(container)
            .environmentObject(authViewModel)
    }
}

#Preview {
    ContentView()
}
