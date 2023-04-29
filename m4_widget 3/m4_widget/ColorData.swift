import Foundation
import SwiftUI

struct ColorData {
    private var COLOR_KEY = "COLOR_KEY"
    private var userDefaults = UserDefaults(suiteName: "YOU_GROUP_NAME")

    func saveTextColor(color: Color) {
        let color = UIColor(color).cgColor

        if let componets = color.components {
            userDefaults?.set(componets, forKey: "COLOR_KEY_TEXT")
        }
    }

    func saveBackgroundColor(color: Color) {
        let color = UIColor(color).cgColor

        if let componets = color.components {
            userDefaults?.set(componets, forKey: COLOR_KEY)
        }
    }

    func loadTextColor() -> Color {
        guard let array = userDefaults?.object(forKey: "COLOR_KEY_TEXT") as?
                [CGFloat] else { return Color.red}
        let color = Color(.sRGB, red: array[0], green: array[1], blue: array[2], opacity: array[3])
        return color
    }

    func loadBackgroundColor() -> Color {
        guard let array = userDefaults?.object(forKey: COLOR_KEY) as?
                [CGFloat] else { return Color.red}
        let color = Color(.sRGB, red: array[0], green: array[1], blue: array[2], opacity: array[3])
        return color
    }
}
