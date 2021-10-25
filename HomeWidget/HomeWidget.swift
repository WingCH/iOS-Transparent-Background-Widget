//
//  HomeWidget.swift
//  HomeWidget
//
//  Created by WingCH on 8/10/2021.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        
        SimpleEntry(date: Date(), image: UIImage())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), image: UIImage())
        
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        if let userDefaults = UserDefaults(suiteName: groupId) {
            
            let safeAreaInsetTop = userDefaults.double(forKey: userDefaultsSharedSafeAreaInsetTop)
            
            var widgetPosition : WidgetPosition = WidgetPosition.leftTop
            if let widgetPositionRawValue = userDefaults.object(forKey: "widgetPosition") as? String{
                widgetPosition = WidgetPosition(rawValue: widgetPositionRawValue)!
            }
            
            var image: UIImage = UIImage()
            if let backgroundImage = userDefaults.data(forKey: userDefaultsSharedBackgroundImage) {
                image = UIImage(data:backgroundImage)!.cropToWidgetSize(
                    safeAreaInsetTop: safeAreaInsetTop,
                    widgetSize: context.displaySize,
                    widgetPosition: widgetPosition
                )
            }
            
            
            entries.append(
                SimpleEntry(date: Date(), image: image)
            )
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        
        
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let image: UIImage
}

struct HomeWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        ZStack {
            Image(uiImage: entry.image)
                .resizable()
                .scaledToFill()
            Image("widgetImage")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
        }
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
        
        HomeWidgetEntryView(entry: SimpleEntry(date: Date(), image: UIImage()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}


