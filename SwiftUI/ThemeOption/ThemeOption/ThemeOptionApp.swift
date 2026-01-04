//
//  ThemeOptionApp.swift
//  ThemeOption
//
//  Created by Hyoju Son on 1/4/26.
//

import SwiftUI

@main
struct ThemeOptionApp: App {
    // 앱 최상위에서 ThemeStore 들고 있음. 여러 화면에 공통 적용하기 때문
    @StateObject private var themeStore = ThemeStore()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(themeStore)
                .preferredColorScheme(themeStore.preferredColorScheme) // 유지
        }
    }
}

// MARK: - RootView
private struct RootView: View {
    // default env
    @Environment(\.colorScheme) private var systemColorScheme
    
    // custom env
    // 최상위 뷰에서 한 번만 계산하고, 하위 뷰에는 자동 반영됨
    private var colorToken: ColorToken {
        ColorToken.colors(
            themeOption: themeStore.selectedTheme,
            systemColorScheme: systemColorScheme
        )
    }

    @EnvironmentObject private var themeStore: ThemeStore
    
    var body: some View {
        ContentView()
            .environment(\.colorToken, colorToken) // custom environment
    }
}

// !!!: Custom Environment 추가하기
private struct ColorTokenKey: EnvironmentKey {
    static let defaultValue: ColorToken = ColorToken.colors(
        themeOption: .system,
        systemColorScheme: .light
    )
}

extension EnvironmentValues {
    var colorToken: ColorToken {
        get { self[ColorTokenKey.self] }
        set { self[ColorTokenKey.self] = newValue }
    }
}

/*
 
 # custom environment 동작 구조
 
 SwiftUI의 전역 설정 가방(Environment)에 ColorToken이라는 값을 넣고, 어디서든 @Environment(\.colorToken)으로 꺼내 쓰게 만든다.
 
 - EnvironmentKey = 사물함 번호(키 타입, 저장할 데이터의 타입)
 - defaultValue = 사물함이 비어있을 때 대신 꺼낼 기본 물건
 - EnvironmentValues.colorToken = 사물함 번호를 ‘colorToken’이라는 손잡이로 만든 것
 - .environment(\.colorToken, value) = 사물함에 실제 물건을 넣는 행위
 - @Environment(\.colorToken) = 사물함에서 물건을 꺼내는 행위
 
 
 # custom environment 방식의 단점
 
 1) 의존성이 “암묵적”이 됨
 뷰 코드만 보면 colors가 어디서 주입되는지 바로 안 보일 수 있어요.
 특히 화면을 따로 떼어서 프리뷰/테스트할 때 주입 누락을 놓치기 쉽습니다.
 
 2) 주입 누락이 “조용히” 넘어갈 수 있음
 EnvironmentKey.defaultValue를 넣어두면 앱이 크래시 나지 않는 대신,
 주입이 빠졌을 때도 “기본 테마로 보여서” 문제를 늦게 발견할 수 있어요.

 3) 변경 범위가 커질 수 있음
 ColorToken이 환경으로 내려가면 값이 바뀔 때 하위 뷰들이 전반적으로 리렌더링됩니다.
 
 */
