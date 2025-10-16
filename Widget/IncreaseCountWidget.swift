//
//  Widget.swift
//  Widget
//
//  Created by Enzo Henrique Botelho Romão on 14/10/25.
//

import WidgetKit
import SwiftUI
import AppIntents

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> CombinedEntry {
        CombinedEntry(date: Date(), count: getCount(), widgetColor: WidgetColor.allColors[0])
    }
    
    func snapshot(for configuration: SelectColorIntent, in context: Context) async -> CombinedEntry {
        CombinedEntry(date: Date(), count: getCount(), widgetColor: configuration.accentColor ?? WidgetColor.allColors[0])
    }
    
    func timeline(for configuration: SelectColorIntent, in context: Context) async -> Timeline<CombinedEntry> {
        let selectedColor = configuration.accentColor ?? WidgetColor.allColors[0]
        
        if let store = UserDefaults(suiteName: "group.henriqenzo.widgets") {
            store.set(selectedColor.id, forKey: "selectedColor")
        }
        
        let entry = CombinedEntry(
            date: .now,
            count: getCount(),
            widgetColor: selectedColor
        )
        
        return Timeline(entries: [entry], policy: .never)
    }
    
    private func getCount() -> Int {
        if let store = UserDefaults(suiteName: "group.henriqenzo.widgets") {
            let count = store.integer(forKey: "count")
            return count
        } else {
            return 0
        }
    }
}

struct CombinedEntry: TimelineEntry {
    let date: Date
    let count: Int
    let widgetColor: WidgetColor
}

struct WidgetEntryView : View {
    var entry: CombinedEntry

    var body: some View {
        VStack(spacing: 10) {
            Text(entry.count, format: .number)
                .font(.system(size: 36, weight: .semibold))
                .foregroundStyle(.black)
            
            HStack(spacing: 20) {
                Button(intent: IncreaseCountIntent()) {
                    Image(systemName: "plus")
                        .foregroundColor(Color.white)
                        .font(.system(size: 24, weight: .bold))
                        .frame(width: 40, height: 40)
                        .background(entry.widgetColor.color)
                        .cornerRadius(20)
                }
                
                Button(intent: SetCountIntent(value: 0)) {
                    Image(systemName: "arrow.trianglehead.counterclockwise")
                        .foregroundColor(Color.white)
                        .font(.system(size: 22, weight: .bold))
                        .frame(width: 40, height: 40)
                        .background(.black.opacity(0.2))
                        .cornerRadius(20)
                }
                .sensoryFeedback(.decrease, trigger: entry.count)
            }
        }
        .buttonStyle(.plain)
    }
}

struct IncreaseCountWidget: Widget {
    let kind: String = "IncreaseCountWidget"
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind,
            intent: SelectColorIntent.self,
            provider: Provider()
        ) { entry in
            WidgetEntryView(entry: entry)
                .containerBackground(for: .widget) {
                    entry.widgetColor.lightColor
                }
        }
        .configurationDisplayName("Counter Widget")
        .description("Increment the counter and choose your accent color.")
        .supportedFamilies([.systemSmall])
    }
}

#Preview(as: .systemSmall) {
    IncreaseCountWidget()
} timeline: {
    CombinedEntry(date: .now, count: 0, widgetColor: WidgetColor.allColors[0])
}
