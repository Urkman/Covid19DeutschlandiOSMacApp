//
//  GermanyItemView.swift
//  covid19
//
//  Created by Stefan Sturm on 11.11.20.
//

import SwiftUI

struct GermanyItemView: View {
    @ObservedObject private var dataStore = DataStore.shared
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text("Deutschland")
                    .font(Application.UI.Fonts.header)
                Spacer()
                Text(dataStore.country.cases7Per100kFormatted)
                    .font(Application.UI.Fonts.incident)
                    .foregroundColor(dataStore.country.color)
            }
            .padding(.horizontal, 10)
            .padding(.top, 10)
            
            VStack(alignment: .center, spacing: 5) {
                HStack {
                    Spacer()
                    VerticalItemView(leftText: "Fälle", rightText: dataStore.country.casesFormatted, color: Color.systemYellow)
                    Spacer()
                    VerticalItemView(leftText: "Neu", rightText: dataStore.country.casesChangesFormatted, color: Color.systemYellow)
                    Spacer()
                    VerticalItemView(leftText: "Aktiv", rightText: dataStore.country.casesActiveFormatted, color: Color.systemYellow)
                    Spacer()
                    VerticalItemView(leftText: "pro 100k", rightText: dataStore.country.casesPer100kFormatted, color: Color.systemYellow)
                    Spacer()
                }
                HStack {
                    Spacer()
                    VerticalItemView(leftText: "Tote", rightText: dataStore.country.deathsFormatted, color: Color.systemRed)
                    Spacer()
                    VerticalItemView(leftText: "Neu", rightText: dataStore.country.deathsChangesFormatted, color: Color.systemRed)
                    Spacer()
                    VerticalItemView(leftText: "Totesrate", rightText: dataStore.country.deathRateFormatted, color: Color.systemRed)
                    Spacer()
                }
                HStack {
                    Spacer()
                    VerticalItemView(leftText: "Impfdosen", rightText: dataStore.country.vaccinatedTotalFormatted, color: Color.systemGreen)
                    Spacer()
                    VerticalItemView(leftText: "Genesen", rightText: dataStore.country.recoveredFormatted, color: Color.systemGreen)
                    Spacer()
                }
            }
            .padding(.bottom, 10)
        }
        .background(Color.cardBackground)
        .cornerRadius(15)
    }
}
