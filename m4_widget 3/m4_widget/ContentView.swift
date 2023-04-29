import SwiftUI
import WidgetKit

struct ContentView: View {
    @State private var text: String = ""
    @State private var textColor: Color = .black
    @State private var backgroundColor: Color = .white
    @State private var futureDate = Date().addingTimeInterval(24 * 60 * 60)
    @State private var colorData = ColorData()

    let defaults = UserDefaults(suiteName: "YOU_GROUP_NAME")

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Данные виджета")) {
                    TextField("Введите текст", text: $text)
                    ColorPicker("Цвет текста", selection: $textColor)
                    ColorPicker("Цвет фона", selection: $backgroundColor)
                    DatePicker(
                        "Дата",
                        selection: $futureDate,
                        in: Date()...,
                        displayedComponents: [.date]
                    )
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Настройки виджета")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Сохранить") {
                        defaults?.set(text, forKey: "Text")
                        defaults?.set(futureDate, forKey: "Date")
                        colorData.saveTextColor(color: textColor)
                        colorData.saveBackgroundColor(color: backgroundColor)
                        WidgetCenter.shared.reloadAllTimelines()
                    }
                }
            }
        }
    }
}
