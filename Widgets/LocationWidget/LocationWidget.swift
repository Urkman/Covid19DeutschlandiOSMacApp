//
//  LocationWidget.swift
//  covid19
//
//  Created by Stefan Sturm on 03.11.20.
//

import WidgetKit
import CoreLocation
import SwiftUI

struct LocationWidgetEntry: TimelineEntry {
    let date: Date
    let country: Location
}

struct LocationProvider: TimelineProvider {
//    private let viewModel = LocationWidgetViewModel()

    func placeholder(in context: Context) -> LocationWidgetEntry {
        LocationWidgetEntry(date: Date(), country: Location.snapShot())
    }

    func getSnapshot(in context: Context, completion: @escaping (LocationWidgetEntry) -> ()) {
        let entry = LocationWidgetEntry(date: Date(), country: Location.snapShot())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<LocationWidgetEntry>) -> ()) {
        LocationManager().fetchLocation { location in
            
        }
//        WidgetsDataStore.shared.loadCountryData { country in
//
//            let entry = LocationWidgetEntry(date: Date(), country: country)
//            let timeline = Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(60 * 10)))
//
//            completion(timeline)
//        }
    }
}


struct LocationWidget: Widget {
    let kind: String = "LocationWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: CountryProvider()) { entry in
            CountryWidgetView(entry: entry)
        }
        .supportedFamilies([.systemSmall, .systemMedium])
        .configurationDisplayName("Standort Widget")
        .description("Zeigt die Daten zum aktuellen Standort an.")
    }
}

struct LocationWidget_Previews: PreviewProvider {
    static var previews: some View {
        CountryWidgetView(entry: CountryWidgetEntry(date: Date(), country: Country.snapShot()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
