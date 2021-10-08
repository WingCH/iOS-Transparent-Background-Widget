//
//  HomeWidget.swift
//  HomeWidget
//
//  Created by WingCH on 8/10/2021.
//

import WidgetKit
import SwiftUI

private let widgetGroupId = "group.com.keep-learning.TransparentHomeWidget"
private let userDefaultsSharedBg = "bg"

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        
        SimpleEntry(date: Date(), image: UIImage(), displaySize: context.displaySize)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), image: UIImage(), displaySize: context.displaySize)
        
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        if let userDefaults = UserDefaults(suiteName: widgetGroupId){
            
            let bg = userDefaults.data(forKey: userDefaultsSharedBg)
            let image = (bg == nil ? UIImage() : UIImage(data: bg!))
            entries.append(
                SimpleEntry(date: Date(), image: image!, displaySize: context.displaySize)
            )
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        
        
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let image: UIImage
    let displaySize: CGSize
}

struct HomeWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        Text(entry.date, style: .time)
            .background(Image(uiImage: entry.image))
    }
}

@main
struct HomeWidget: Widget {
    let kind: String = "HomeWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            HomeWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct HomeWidget_Previews: PreviewProvider {
    static var previews: some View {
        HomeWidgetEntryView(entry: SimpleEntry(date: Date(), image: UIImage(), displaySize: CGSize(width: 170, height: 170)))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
