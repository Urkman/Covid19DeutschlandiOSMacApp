//
//  LocationWidgetView.swift
//  covid19
//
//  Created by Stefan Sturm on 03.11.20.
//

import SwiftUI

struct LocationWidgetView: View {
    var entry: CountryProvider.Entry
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Deutschland")
                .font(.caption)
            HStack {
                Spacer()
                
                Text(entry.country.cases7Per100kFormatted)
                    .foregroundColor(entry.country.color)
                    .font(.body)
            }
            Text("Fälle")
                .font(.caption)
            HStack {
                Spacer()
                Text(entry.country.casesFormatted)
                    .font(.caption2)
                    .foregroundColor(Color.systemYellow)
                Text("+\(entry.country.casesChangesFormatted)")
                    .font(.caption2)
                    .foregroundColor(Color.systemYellow)
            }
            
            Text("Tote")
                .font(.caption)
            HStack {
                Spacer()
                Text(entry.country.deathsFormatted)
                    .font(.caption2)
                    .foregroundColor(Color.systemRed)
                Text("+\(entry.country.deathsChangesFormatted)")
                    .font(.caption2)
                    .foregroundColor(Color.systemRed)
            }
            Spacer()

        }.padding()
    }
}

struct LocationWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        LocationWidgetView(entry: CountryWidgetEntry(date: Date(), country: Country.snapShot()))
    }
}
