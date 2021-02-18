//
//  ProviceVaccinated.swift
//  covid19
//
//  Created by Stefan Sturm on 24.01.21.
//

import SwiftUI

struct ProvinceVaccinatedView: View {
    var province: Province
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Impfungen")
                .font(.title3)
                .padding(.horizontal, 10)
                .padding([.top], 10)

            HStack {
                Group {
                    Spacer()
                    VerticalItemView(leftText: "Geimpft", rightText: province.vaccinatedFormatted, color: Color.systemGreen)
                    Spacer()
                    VerticalItemView(leftText: "Differenz", rightText: province.vaccinatedDifferenceFormatted, color: Color.systemGreen)
                    Spacer()
                }
                VerticalItemView(leftText: "Zweitimpung", rightText: province.vaccinatedSecondFormatted, color: Color.systemGreen)
                Spacer()
                VerticalItemView(leftText: "Differenz", rightText: province.vaccinatedSeccondDifferenceFormatted, color: Color.systemGreen)
                Spacer()
            }
            .padding(.horizontal, 10)
            
            HStack {
                Spacer()
                VerticalItemView(leftText: "Impfdosen", rightText: province.vaccinatedTotalFormatted, color: Color.systemGreen)
                Spacer()
                VerticalItemView(leftText: "Quote", rightText: province.vaccinatedQuoteFormatted, color: Color.systemGreen)
                Spacer()
                VerticalItemView(leftText: "Biontech", rightText: province.vaccinatedBiontechFormatted, color: Color.systemGreen)
                Spacer()
                VerticalItemView(leftText: "Moderna", rightText: province.vaccinatedModernaFormatted, color: Color.systemGreen)
                Spacer()
            }
            .padding(.horizontal, 10)
            .padding([.bottom], 10)
        }
        .background(Color.secondarySystemBackground)
        .cornerRadius(15)
    }
}
