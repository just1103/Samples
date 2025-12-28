//
//  ContentView.swift
//  Locale
//
//  Created by Hyoju Son on 12/28/25.
//

import SwiftUI
import SwiftData
import Foundation

enum LanguageOptions: String, CaseIterable {
    case korean = "ko"
    case english = "en"
}

class AppSettings: ObservableObject {
    @Published var selectedLanguage: LanguageOptions
    
    init(selectedLanguage: LanguageOptions?) {
        // 기본값 설정
        // 유저의 preferred language가 "ko" 이면 "ko", 나머지이면 "en"
        self.selectedLanguage = selectedLanguage ?? .english
    }
}

/*
 - 설정 데이터(AppSettings)는 항상 1개만 유지
 - 앱을 최초 실행할 때, 시스템 설정의 preferred language를 가져와서 기본값으로 설정 및 로컬에 저장 (SwiftData)
 - picker에서 선택한 언어 옵션을 로컬에 저장 (SwiftData)
 - 언어 옵션이 바뀌면 화면 재갱신
 */

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    @ObservedObject var appSettings: AppSettings

    var body: some View {
        NavigationSplitView {
            List {
                Section(header: Text("앱 설정")) {
                    HStack(spacing: 0) {
                        Image(systemName: "globe")
                        
                        Text("언어")
                            .padding(.leading, 14)
                        
                        Spacer(minLength: 0)
                        
                        Picker("", selection: $appSettings.selectedLanguage) {
                            ForEach(LanguageOptions.allCases, id: \.self) { option in
                                Text(option.rawValue)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                }
                
                // TODO: 이게
                Text("안녕하세요")
                
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView(
        appSettings: AppSettings(selectedLanguage: nil)
    )
    .modelContainer(for: Item.self, inMemory: true)
}
