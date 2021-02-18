//
//  CountyListItemView.swift
//  covid19
//
//  Created by Stefan Sturm on 23.10.20.
//

import SwiftUI

struct CountyListItemView: View {
    let county: County
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(alignment: .center, spacing: 5) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(county.name)
                        .font(Application.UI.Fonts.header)
                        .lineLimit(1)
                    Text(county.province)
                        .font(Application.UI.Fonts.subheader)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
                Spacer()
                Text(county.cases7Per100kFormatted)
                    .font(Application.UI.Fonts.incident)
                    .foregroundColor(county.color)
            }
            .padding(.horizontal, 10)

            HStack(alignment: .center, spacing: 5) {
                Spacer()
                VerticalItemView(leftText: "Fälle", rightText: county.casesFormatted, color: Color.systemYellow)
                Spacer()
                VerticalItemView(leftText: "Neu", rightText: county.casesNewFormatted, color: Color.systemYellow)
                Spacer()
                VerticalItemView(leftText: "Tote", rightText: county.deathsFormatted, color: Color.systemRed)
                Spacer()
                VerticalItemView(leftText: "Neu", rightText: county.deathsNewFormatted, color: Color.systemRed)
                Spacer()
            }
        }.padding(.vertical, 10)
    }
}
