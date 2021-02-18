//
//  ProvinceListItemView.swift
//  covid19
//
//  Created by Stefan Sturm on 23.10.20.
//

import SwiftUI

struct ProvinceListItemView: View {    
    let province: Province
    let showVaccination: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(alignment: .center, spacing: 5) {
                Text(province.name)
                    .font(Application.UI.Fonts.subheader)
                Spacer()
                if !showVaccination {
                    Text(province.cases7Per100kFormatted)
                        .font(Application.UI.Fonts.incident)
                        .foregroundColor(province.color)
                }
            }.padding(.horizontal, 10)
            
            VStack(alignment: .center, spacing: 5) {
                if !showVaccination {
                    HStack(alignment: .center, spacing: 5) {
                        Spacer()
                        VerticalItemView(leftText: "Fälle", rightText: province.casesFormatted, color: Color.systemYellow)
                        Spacer()
                        VerticalItemView(leftText: "Neu", rightText: province.casesNewFormatted, color: Color.systemYellow)
                        Spacer()
                        VerticalItemView(leftText: "Aktiv", rightText: province.casesActiveFormatted, color: Color.systemYellow)
                        Spacer()
                        VerticalItemView(leftText: "pro 100k", rightText: province.casesPer100kFormatted, color: Color.systemYellow)
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        VerticalItemView(leftText: "Tote", rightText: province.deathsFormatted, color: Color.systemRed)
                        Spacer()
                        VerticalItemView(leftText: "Neu", rightText: province.deathsNewFormatted, color: Color.systemRed)
                        Spacer()
                        VerticalItemView(leftText: "Totesrate", rightText: province.deathRateFormatted, color: Color.systemRed)
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        VerticalItemView(leftText: "Impfdosen", rightText: province.vaccinatedTotalFormatted, color: Color.systemGreen)
                        Spacer()
                        VerticalItemView(leftText: "Genesen", rightText: province.recoveredFormatted, color: Color.systemGreen)
                        Spacer()
                    }
                } else {
                    HStack {
                        Spacer()
                        VerticalItemView(leftText: "ErstImpfung", rightText: province.vaccinatedFormatted, color: Color.systemGreen)
                        Spacer()
                        VerticalItemView(leftText: "Differenz", rightText: province.vaccinatedDifferenceFormatted, color: Color.systemGreen)
                        Spacer()
                        VerticalItemView(leftText: "Quote", rightText: province.vaccinatedQuoteFormatted, color: Color.systemGreen)
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        VerticalItemView(leftText: "Zweitimpfung", rightText: province.vaccinatedSecondFormatted, color: Color.systemGreen)
                        Spacer()
                        VerticalItemView(leftText: "Differenz", rightText: province.vaccinatedSeccondDifferenceFormatted, color: Color.systemGreen)
                        Spacer()
                        VerticalItemView(leftText: "Quote", rightText: province.vaccinatedSecondQuoteFormatted, color: Color.systemGreen)
                        Spacer()
                    }
                }
            }
        }
        .padding(.vertical, 10)
    }
}
