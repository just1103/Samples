import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationStack {
                FirstTabView()
            }
            .tabItem {
                Image(systemName: "circle")
                Text("First")
            }
            
            NavigationStack {
                SecondTabView()
            }
            .tabItem {
                Image(systemName: "circle")
                Text("Second")
            }
            
            NavigationStack {
                ThirdTabView()
            }
            .tabItem {
                Image(systemName: "circle")
                Text("Third")
            }
        }
    }
}

struct FirstTabView: View {
    var body: some View {
        VStack {
            Text("First Tab")
            NavigationLink("Go to Detail") {
                DetailView(title: "First Tab Detail")
            }
        }
        .navigationTitle("First")
    }
}

struct SecondTabView: View {
    var body: some View {
        VStack {
            Text("Second Tab")
            NavigationLink("Go to Detail") {
                DetailView(title: "Second Tab Detail")
            }
        }
        .navigationTitle("Second")
    }
}

struct ThirdTabView: View {
    var body: some View {
        VStack {
            Text("Third Tab")
            NavigationLink("Go to Detail") {
                DetailView(title: "Third Tab Detail")
            }
        }
        .navigationTitle("Third")
    }
}

struct DetailView: View {
    let title: String
    
    var body: some View {
        // FIXME: back 했을 때 tabBar가 늦게 나타남 
        Text(title)
            .navigationTitle(title)
            .toolbar(.hidden, for: .tabBar)
    }
}
