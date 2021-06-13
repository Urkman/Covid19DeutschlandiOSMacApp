//
//  GermanyBedsItemView.swift
//  covid19
//
//  Created by Stefan Sturm on 11.11.20.
//

import SwiftUI

struct GermanyBedsItemView: View {
    @ObservedObject private var dataStore = DataStore.shared
    @State var showBeds: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(alignment: .center, spacing: 5) {
                Text("Intensivbetten")
                    .font(Application.UI.Fonts.header)
                Spacer()
                Button(action: {
                    showBeds.toggle()
                }, label: {
                    Image(systemName: "chevron.right")
                }).foregroundColor(.label)
            }
            .padding(.horizontal, 10)
            .padding(.top, 10)
            .sheet(isPresented: $showBeds) {
                BedsView()
            }

            HStack {
                Spacer()
                VerticalItemView(leftText: "Gesamt", rightText: dataStore.country.bedsTotalFormatted, color: Color.systemYellow)
                Spacer()
                VerticalItemView(leftText: "Belegt", rightText: dataStore.country.bedsUsedFormatted, color: Color.systemRed)
                Spacer()
                VerticalItemView(leftText: "Frei", rightText: dataStore.country.bedsFreeFormatted, color: Color.systemGreen)
                Spacer()
            }
            .padding(.horizontal, 10)
            
            HStack {
                Spacer()
                VerticalItemView(leftText: "Covid", rightText: dataStore.country.bedsCovidFormatted, color: Color.systemYellow)
                Spacer()
                VerticalItemView(leftText: "Beatmet", rightText: dataStore.country.bedsCovidVentilateFormatted, color: Color.systemRed)
                Spacer()
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 10)
            
        }
        .background(Color.cardBackground)
        .cornerRadius(15)
    }
}
