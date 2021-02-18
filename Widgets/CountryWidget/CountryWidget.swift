//
//  CountryWidget.swift
//  CountryWidget
//
//  Created by Stefan Sturm on 30.10.20.
//

import WidgetKit
import SwiftUI

struct CountryWidgetEntry: TimelineEntry {
    let date: Date
    let country: Country
}

struct CountryProvider: TimelineProvider {
    func placeholder(in context: Context) -> CountryWidgetEntry {
        CountryWidgetEntry(date: Date(), country: Country.snapShot())
    }

    func getSnapshot(in context: Context, completion: @escaping (CountryWidgetEntry) -> ()) {
        let entry = CountryWidgetEntry(date: Date(), country: Country.snapShot())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<CountryWidgetEntry>) -> ()) {
        WidgetsDataStore.shared.loadCountryData { country in
            
            let entry = CountryWidgetEntry(date: Date(), country: country)
            let timeline = Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(60 * 10)))
            
            completion(timeline)
        }
    }
}


struct CountryWidget: Widget {
    let kind: String = "CountryWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: CountryProvider()) { entry in
            CountryWidgetView(entry: entry)
        }
        .supportedFamilies([.systemSmall, .systemMedium])
        .configurationDisplayName("Deutschland Widget")
        .description("Zeigt die aktuellen Daten von Deutschland an.")
    }
}

struct CountryWidget_Previews: PreviewProvider {
    static var previews: some View {
        CountryWidgetView(entry: CountryWidgetEntry(date: Date(), country: Country.snapShot()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
