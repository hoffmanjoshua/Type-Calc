//
//  Type_Calc_Widget.swift
//  Type Calc Widget
//
//  Created by Joshua Hoffman on 10/4/20.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct Type_Calc_WidgetEntryView : View {
    var body: some View {
        VStack {
            Text("Type Calc")
                .font(.system(size: 25))
                .bold()
            Rectangle()
                .foregroundColor(.clear)
                .background(LinearGradient(gradient:  Gradient(colors: [Color(#colorLiteral(red: 0.3294117647, green: 0.2549019608, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.09411764706, green: 0.3333333333, blue: 1, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                .cornerRadius(5)
                .padding(.horizontal, 5)
                .frame(height: 7)
                .shadow(radius: 20)
            HStack {
                Text("I")
                Spacer()
            }
            .padding(.horizontal)
            .background(Color(UIColor.tertiarySystemFill))
            .cornerRadius(5)
            .font(.system(size: 30, weight: .ultraLight, design: .serif))
            .padding(.horizontal)
        }
        
    }
}

@main
struct Type_Calc_Widget: Widget {
    let kind: String = "Type_Calc_Widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            Type_Calc_WidgetEntryView()
        }
        .configurationDisplayName("Type Calc")
        .description("Quickly access the calculator from your homescreen.")
    }
}

struct Type_Calc_Widget_Previews: PreviewProvider {
    static var previews: some View {
        Type_Calc_WidgetEntryView()
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
