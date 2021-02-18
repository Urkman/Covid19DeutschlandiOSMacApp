//
//  ProvinceListBedsItemView.swift
//  covid19
//
//  Created by Stefan Sturm on 11.11.20.
//

import SwiftUI

struct ProvinceListBedsItemView: View {
    let province: Province
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(alignment: .center, spacing: 5) {
                Text(province.name)
                    .font(Application.UI.Fonts.subheader)
                Spacer()
            }.padding(.horizontal, 10)
            
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
            }
            .padding(.horizontal, 10)
            
            HStack {
                Spacer()
                VerticalItemView(leftText: "Covid", rightText: province.bedsCovidFormatted, color: Color.systemYellow)
                Spacer()
                VerticalItemView(leftText: "Beatmet", rightText: province.bedsCovidVentilateFormatted, color: Color.systemRed)
                Spacer()
            }
            .padding(.horizontal, 10)

        }.padding(.vertical, 10)
    }
}
