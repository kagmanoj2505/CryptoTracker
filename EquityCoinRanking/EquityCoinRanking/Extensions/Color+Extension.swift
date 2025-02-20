//
//  Color.swift
//  EquityCoinRanking
//
//  Created by Kag Manoj on 19/2/25.
//

import SwiftUI
import UIKit

extension Color {
    static let theme = ColorTheme()
}
// UIKit UIColor Extension
extension UIColor {
    static let theme = UIColorTheme()
}
struct ColorTheme {
    let accent = Color("AccentColor")
    let text = Color("Text")
    let secondaryText = Color("SecondaryText")
    let lightGray = Color("LightGray")
    let green = Color("Green")
    let red = Color("Red")
}

// UIKit UIColor Theme
struct UIColorTheme {
    let accent = UIColor(named: "AccentColor")
    let text = UIColor(named: "Text")
    let secondaryText = UIColor(named: "SecondaryText")
    let lightGray = UIColor(named: "LightGray")
    let green = UIColor(named: "Green")
    let red = UIColor(named: "Red")
}

