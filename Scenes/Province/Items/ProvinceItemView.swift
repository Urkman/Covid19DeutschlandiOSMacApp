//
//  ProvinceItemView.swift
//  covid19
//
//  Created by Stefan Sturm on 17.11.20.
//

import SwiftUI

struct ProvinceItemView: View {
    var province: Province

    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(province.name)
                    .font(Application.UI.Fonts.header)
                Spacer()
                Text(province.cases7Per100kFormatted)
                    .font(Application.UI.Fonts.incident)
                    .foregroundColor(province.color)
            }
            .padding(.horizontal, 10)
            .padding([.top], 10)
            
            HStack {
                Group {
                    Spacer()
                    VerticalItemView(leftText: "Fälle", rightText: province.casesFormatted, color: Color.systemYellow)
                    Spacer()
                    VerticalItemView(leftText: "Neu", rightText: province.casesNewFormatted, color: Color.systemYellow)
                    Spacer()
                    VerticalItemView(leftText: "Tote", rightText: province.deathsFormatted, color: Color.systemRed)
                    Spacer()
                }
                VerticalItemView(leftText: "Neu", rightText: province.deathsNewFormatted, color: Color.systemRed)
                Spacer()
                VerticalItemView(leftText: "Genesen", rightText: province.recoveredFormatted, color: Color.systemGreen)
                Spacer()
            }
            .padding(.horizontal, 10)
            
            if horizontalSizeClass == .compact {
                VStack(alignment: .leading, spacing: 15) {
                    HorizontalItemView(leftText: "Einwohner", rightText: province.populationFormatted)
                    HorizontalItemView(leftText: "Fälle pro 100.000 Einwohner", rightText: province.casesPer100kFormatted)
                    HorizontalItemView(leftText: "Infektionsrate", rightText: province.casesPerPopulationFormatted)
                    HorizontalItemView(leftText: "Totesrate", rightText: province.deathRateFormatted)
                }
                .padding(.horizontal, 10)
                .padding([.bottom], 10)
            } else {
                HStack {
                    Spacer()
                    VerticalItemView(leftText: "Einwohner", rightText: province.populationFormatted)
                    Group {
                        Spacer()
                        VerticalItemView(leftText: "Fälle 100k", rightText: province.casesPer100kFormatted, color: Color.systemYellow)
                        Spacer()
                        VerticalItemView(leftText: "Infektionsrate", rightText: province.casesPerPopulationFormatted, color: Color.systemYellow)
                        Spacer()
                        VerticalItemView(leftText: "Totesrate", rightText: province.deathRateFormatted, color: Color.systemRed)
                        Spacer()
                    }
                }
                .padding(.horizontal, 10)
                .padding([.bottom], 10)
            }
        }
        .background(Color.secondarySystemBackground)
        .cornerRadius(15)
    }
}
