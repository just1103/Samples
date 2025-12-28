//
//  ContentView.swift
//  Locale
//
//  Created by Hyoju Son on 12/28/25.
//

import SwiftUI
import SwiftData

/*
 - 앱을 최초 실행할 때, 시스템 설정의 preferred language를 가져와서 기본값으로 설정 및 로컬에 저장 (SwiftData, 디스크 저장)
 - picker에서 선택한 언어 옵션을 로컬에 저장 (SwiftData)
 - 언어 옵션이 바뀌면 화면 재갱신
 - 앱을 재실행 하면, 시스템 설정과 상관없이 로컬에 저장한 값을 읽어와서 화면에 반영함
 */

struct ContentView: View {
    @Environment(\.locale) private var locale
    
    // SwiftData
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    // AppRootView에서 받아온 값
    @Binding var selectedLanguage: LanguageOptions

    var body: some View {
        NavigationSplitView {
            List {
                Section(header: Text("앱 설정")) {
                    HStack(spacing: 0) {
                        Image(systemName: "globe")
                        
                        Text("언어")
                            .padding(.leading, 14)
                        
                        Spacer(minLength: 0)
                        
                        Picker("", selection: $selectedLanguage) {
                            ForEach(LanguageOptions.allCases, id: \.self) { option in
                                Text(option.rawValue)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                }
                
                Section(header: Text("현재 Locale")) {
                    Text("안녕하세요")
                    Text(locale.identifier)
                    Text(Date.now, format: .dateTime.year().month().day().weekday())
                }
                
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
//        .environment(\.locale, Locale(identifier: selectedLanguage.rawValue)) // 밖에서만 걸어줘도 됨
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
    PreviewContainerView()
        .modelContainer(for: [Item.self, AppSettingsEntity.self], inMemory: true)
}

private struct PreviewContainerView: View {
    @State private var selectedLanguage: LanguageOptions = .english

    var body: some View {
        ContentView(selectedLanguage: $selectedLanguage)
            .environment(\.locale, Locale(identifier: selectedLanguage.rawValue))
    }
}
