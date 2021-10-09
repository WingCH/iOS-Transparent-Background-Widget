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
private let userDefaultsSharedSafeAreaInsetTop = "safeAreaInsetTop"

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
            let userDefaultsSharedSafeAreaInsetTop = userDefaults.double(forKey: userDefaultsSharedSafeAreaInsetTop) 
            
            var image: UIImage = UIImage()
            if ((bg) != nil){
//                let window = UIApplication.shared.windows.first
//                let safeAreaPadding = window?.safeAreaInsets.top
  
                image = UIImage(data: bg!)!.cropToWidgetSize(safeAreaInsetTop: userDefaultsSharedSafeAreaInsetTop, width: context.displaySize.width, height: context.displaySize.height)

            }
            
            
            entries.append(
                SimpleEntry(date: Date(), image: image, displaySize: CGSize(width: context.displaySize.width, height: context.displaySize.height))
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
        ZStack {
            Image(uiImage: entry.image)
                .resizable()
                .scaledToFill()
            Text(entry.displaySize.debugDescription)
                .foregroundColor(Color.orange)
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
        
        HomeWidgetEntryView(entry: SimpleEntry(date: Date(), image: UIImage(), displaySize: CGSize(width: 170, height: 170)))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}


