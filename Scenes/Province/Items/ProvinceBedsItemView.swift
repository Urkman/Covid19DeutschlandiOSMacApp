//
//  ProvinceBedsItemView.swift
//  covid19
//
//  Created by Stefan Sturm on 17.11.20.
//

import SwiftUI

struct ProvinceBedsItemView: View {
    var province: Province
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Intensivbetten")
                .font(.title3)
                .padding(.horizontal, 10)
                .padding([.top], 10)

            HStack {
                Group {
                Spacer()
                    VerticalItemView(leftText: "Gesamt", rightText: province.bedsTotalFormatted, color: Color.systemYellow)
                Spacer()
                    VerticalItemView(leftText: "Belegt", rightText: province.bedsUsedFormatted, color: Color.systemRed)
                Spacer()
                    VerticalItemView(leftText: "Frei", rightText: province.bedsFreeFormatted, color: Color.systemGreen)
                Spacer()
                }
                VerticalItemView(leftText: "Covid", rightText: province.bedsCovidFormatted, color: Color.systemYellow)
                Spacer()
                VerticalItemView(leftText: "Beatmet", rightText: province.bedsCovidVentilateFormatted, color: Color.systemRed)
                Spacer()
            }
            .padding(.horizontal, 10)
            .padding([.bottom], 10)
        }
        .background(Color.secondarySystemBackground)
        .cornerRadius(15)
    }
}
