import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    let colorData = ColorData()
    func placeholder(in context: Context) -> SimpleEntry {
        let text = UserDefaults(suiteName: "YOU_GROUP_NAME")?.string(forKey: "Text") ?? ""
        let futureDate = UserDefaults(
            suiteName: "YOU_GROUP_NAME")?.object(forKey: "Date") as? Date ?? Date()
        let textColor = colorData.loadTextColor()
        let backgroundColor = colorData.loadBackgroundColor()
        return SimpleEntry(
            date: Date(),
            text: text,
            futureDate: futureDate,
            textColor: textColor,
            backgroundColor: backgroundColor,
            configuration: ConfigurationIntent()
        )
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let text = UserDefaults(suiteName: "YOU_GROUP_NAME")?.string(forKey: "Text") ?? ""
        let futureDate = UserDefaults(suiteName: "YOU_GROUP_NAME")?.object(forKey: "Date") as? Date ?? Date()
        let textColor = colorData.loadTextColor()
        let backgroundColor = colorData.loadBackgroundColor()
        let entry = SimpleEntry(
            date: Date(),
            text: text,
            futureDate: futureDate,
            textColor: textColor,
            backgroundColor: backgroundColor,
            configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        let text = UserDefaults(suiteName: "YOU_GROUP_NAME")?.string(forKey: "Text") ?? ""
        let futureDate = UserDefaults(suiteName: "YOU_GROUP_NAME")?.object(forKey: "Date") as? Date ?? Date()
        let textColor = colorData.loadTextColor()
        let backgroundColor = colorData.loadBackgroundColor()
        let entry = SimpleEntry(
            date: Date(),
            text: text,
            futureDate: futureDate,
            textColor: textColor,
            backgroundColor: backgroundColor,
            configuration: configuration)
        entries.append(entry)

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let text: String
    let futureDate: Date
    let textColor: Color
    let backgroundColor: Color
    let configuration: ConfigurationIntent
}

struct WidgetEntryView: View {

    var entry: Provider.Entry
    @State var color: Color = .black

    var body: some View {
        ZStack {
            entry.backgroundColor
            VStack {
                Text(entry.text)
                    .font(.system(size: 20))
                    .foregroundColor(entry.textColor)
                Text(entry.futureDate, style: .relative)
                    .font(.system(size: 10))
                    .padding(2)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

struct MyWidgetMediumEnterView: View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            entry.backgroundColor
            VStack {
                Text(entry.text)
                    .font(.system(size: 30))
                    .foregroundColor(entry.textColor)
                Text(entry.futureDate, style: .relative)
                    .font(.system(size: 20))
                    .padding(2)
                    .multilineTextAlignment(.center)

            }
        }
    }
}

struct MyWidgetLargeEnterView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            entry.backgroundColor
            VStack {
                Text(entry.text)
                    .font(.system(size: 50))
                    .foregroundColor(entry.textColor)
                Text(entry.futureDate, style: .relative)
                    .font(.system(size: 40))
                    .padding(2)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

struct MyWidget: Widget {
    let kind: String = "MyWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Это Ваш новый виджет")
        .description("Настройте его, выбрав дату, цвет текста и фона")
        .supportedFamilies([.systemSmall])
    }
}

struct MyWidgetMedium: Widget {
    let kind: String = "MyWidgetMedium"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            MyWidgetMediumEnterView(entry: entry)
        }
        .configurationDisplayName("Это Ваш новый виджет")
        .description("Настройте его, выбрав дату, цвет текста и фона")
        .supportedFamilies([.systemMedium])
    }
}

struct MyWidgetLarge: Widget {
    let kind: String = "MyWidgetLarge"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            MyWidgetLargeEnterView(entry: entry)
        }
        .configurationDisplayName("Это Ваш новый виджет")
        .description("Настройте его, выбрав дату, цвет текста и фона")
        .supportedFamilies([.systemLarge])
    }
}
