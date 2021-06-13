//
//  GermanyVaccinatedView.swift
//  covid19
//
//  Created by Stefan Sturm on 24.01.21.
//

import SwiftUI

struct GermanyVaccinatedView: View {
    @ObservedObject private var dataStore = DataStore.shared
    var header: String = "Impfungen"

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(header)
                .font(Application.UI.Fonts.header)
                .padding(.horizontal, 10)
                .padding([.top], 10)

            HStack {
                Group {
                    Spacer()
                    VerticalItemView(leftText: "Geimpft", rightText: dataStore.country.vaccinatedFormatted, color: Color.systemGreen)
                    Spacer()
                    VerticalItemView(leftText: "Differenz", rightText: dataStore.country.vaccinatedDifferenceFormatted, color: Color.systemGreen)
                    Spacer()
                    VerticalItemView(leftText: "Quote", rightText: dataStore.country.vaccinatedQuoteFormatted, color: Color.systemGreen)
                    Spacer()
                }
            }
            .padding(.horizontal, 10)

            HStack {
                Group {
                    Spacer()
                    VerticalItemView(leftText: "Zweitimpung", rightText: dataStore.country.vaccinatedSecondFormatted, color: Color.systemGreen)
                    Spacer()
                    VerticalItemView(leftText: "Differenz", rightText: dataStore.country.vaccinatedSeccondDifferenceFormatted, color: Color.systemGreen)
                    Spacer()
                    VerticalItemView(leftText: "Quote", rightText: dataStore.country.vaccinatedSecondQuoteFormatted, color: Color.systemGreen)
                    Spacer()
                }
            }
            .padding(.horizontal, 10)
        }
        .padding(.bottom, 10)
        .background(Color.cardBackground)
        .cornerRadius(15)
    }
}
