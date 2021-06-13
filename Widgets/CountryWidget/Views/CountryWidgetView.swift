//
//  CountryWidgetView.swift
//  covid19
//
//  Created by Stefan Sturm on 01.11.20.
//

import WidgetKit
import SwiftUI

struct CountryWidgetView : View {
    var entry: CountryProvider.Entry
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text("BRD")
                    .font(Application.Widgets.Fonts.header)
                Spacer()
                Text(entry.country.cases7Per100kFormatted)
                    .foregroundColor(entry.country.color)
                    .font(Application.Widgets.Fonts.incident)
            }
            VStack(alignment: .center, spacing: 5) {
                HStack {
                    Image(systemName: "staroflife")
                        .font(Application.Widgets.Fonts.icons)
                        .foregroundColor(Color.systemYellow)
                        .frame(width: 20)
                    Spacer()
                    VStack(alignment: .trailing, spacing: 2) {
                        Text(entry.country.casesFormatted)
                            .font(Application.Widgets.Fonts.value)
                            .foregroundColor(Color.systemYellow)
                        Text("+\(entry.country.casesChangesFormatted)")
                            .font(Application.Widgets.Fonts.value)
                            .foregroundColor(Color.systemYellow)
                    }
                }
                
                HStack {
                    Image("cross")
                        .resizable()
                        .aspectRatio(1.0, contentMode: .fit)
                        .foregroundColor(Color.systemRed)
                        .frame(width: 20)
                    Spacer()
                    VStack(alignment: .trailing, spacing: 2) {
                        Text(entry.country.deathsFormatted)
                            .font(Application.Widgets.Fonts.value)
                            .foregroundColor(Color.systemRed)
                        Text("+\(entry.country.deathsChangesFormatted)")
                            .font(Application.Widgets.Fonts.value)
                            .foregroundColor(Color.systemRed)
                    }
                }
                HStack {
                    Image(systemName: "heart")
                        .font(Application.Widgets.Fonts.icons)
                        .foregroundColor(Color.systemGreen)
                        .frame(width: 20)
                    Spacer()
                    Text(entry.country.recoveredFormatted)
                        .font(Application.Widgets.Fonts.value)
                        .foregroundColor(Color.systemGreen)
                }
            }
            Spacer()
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
    }
}

struct CountryWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        CountryWidgetView(entry: CountryWidgetEntry(date: Date(), country: Country.snapShot()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
