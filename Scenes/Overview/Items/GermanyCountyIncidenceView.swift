//
//  GermanyCountyIncidenceView.swift
//  covid19
//
//  Created by Stefan Sturm on 13.02.21.
//

import SwiftUI

struct GermanyCountyIncidenceView: View {
    @ObservedObject private var dataStore = DataStore.shared

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text("Inzidenzen Landkreise")
                    .font(Application.UI.Fonts.header)
                Spacer()
            }
            .padding(.horizontal, 10)
            .padding(.top, 10)

            HStack {
                Text("größer 150")
                    .font(Application.UI.Fonts.valueLabel)
                    .foregroundColor(.gray)
                Spacer()
                Text("\(dataStore.countyIncidence(over: 150).count)")
                    .font(Application.UI.Fonts.value)
                    .foregroundColor(Color.color(forIncidence: 151))
            }
            .padding(.horizontal, 10)
            HStack {
                Text("100 bis 150")
                    .font(Application.UI.Fonts.valueLabel)
                    .foregroundColor(.gray)
                Spacer()
                Text("\(dataStore.countyIncidence(over: 100).count)")
                    .font(Application.UI.Fonts.value)
                    .foregroundColor(Color.color(forIncidence: 101))
            }
            .padding(.horizontal, 10)
            HStack {
                Text("50 bis 100")
                    .font(Application.UI.Fonts.valueLabel)
                    .foregroundColor(.gray)
                Spacer()
                Text("\(dataStore.countyIncidence(over: 50, under: 100).count)")
                    .font(Application.UI.Fonts.value)
                    .foregroundColor(Color.color(forIncidence: 51))
            }
            .padding(.horizontal, 10)
            HStack {
                Text("35 bis 50")
                    .font(Application.UI.Fonts.valueLabel)
                    .foregroundColor(.gray)
                Spacer()
                Text("\(dataStore.countyIncidence(over: 35, under: 50).count)")
                    .font(Application.UI.Fonts.value)
                    .foregroundColor(Color.color(forIncidence: 36))
            }
            .padding(.horizontal, 10)
            HStack {
                Text("25 bis 35")
                    .font(Application.UI.Fonts.valueLabel)
                    .foregroundColor(.gray)
                Spacer()
                Text("\(dataStore.countyIncidence(over: 25, under: 35).count)")
                    .font(Application.UI.Fonts.value)
                    .foregroundColor(Color.color(forIncidence: 26))
            }
            .padding(.horizontal, 10)
            HStack {
                Text("kleiner 25")
                    .font(Application.UI.Fonts.valueLabel)
                    .foregroundColor(.gray)
                Spacer()
                Text("\(dataStore.countyIncidence(under: 25).count)")
                    .font(Application.UI.Fonts.value)
                    .foregroundColor(Color.color(forIncidence: 24))
            }
            .padding(.horizontal, 10)
        }
        .padding(.bottom, 10)
        .background(Color.cardBackground)
        .cornerRadius(15)
    }
}

struct GermanyCountyIncidenceView_Previews: PreviewProvider {
    static var previews: some View {
        GermanyCountyIncidenceView()
    }
}
