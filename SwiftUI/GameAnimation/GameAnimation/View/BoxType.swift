//
//  BoxType.swift
//  GameAnimation
//
//  Created by Hyoju Son on 9/7/25.
//

import SwiftUI

enum BoxType {
    case red
    case yellow
    case green
    
    var color: Color {
        return switch self {
        case .red: .red
        case .yellow: .yellow
        case .green: .green
        }
    }
}
