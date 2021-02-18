//
//  GermanyProvinceIncidenceView.swift
//  covid19
//
//  Created by Stefan Sturm on 13.02.21.
//

import SwiftUI

struct GermanyProvinceIncidenceView: View {
    @ObservedObject private var dataStore = DataStore.shared
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text("Inzidenzen Bundesländer")
                    .font(Application.UI.Fonts.header)
                Spacer()
            }
            .padding(.horizontal, 10)
            .padding(.top, 10)

            HStack {
                Text("grö0er 150")
                    .font(Application.UI.Fonts.valueLabel)
                    .foregroundColor(.gray)
                Spacer()
                Text("\(dataStore.provinceIncidence(over: 150).count)")
                    .font(Application.UI.Fonts.value)
                    .foregroundColor(Color.color(forIncidence: 151))
            }
            .padding(.horizontal, 10)
            HStack {
                Text("100 bis 150")
                    .font(Application.UI.Fonts.valueLabel)
                    .foregroundColor(.gray)
                Spacer()
                Text("\(dataStore.provinceIncidence(over: 100).count)")
                    .font(Application.UI.Fonts.value)
                    .foregroundColor(Color.color(forIncidence: 101))
            }
            .padding(.horizontal, 10)
            HStack {
                Text("50 bis 100")
                    .font(Application.UI.Fonts.valueLabel)
                    .foregroundColor(.gray)
                Spacer()
                Text("\(dataStore.provinceIncidence(over: 50, under: 100).count)")
                    .font(Application.UI.Fonts.value)
                    .foregroundColor(Color.color(forIncidence: 51))
            }
            .padding(.horizontal, 10)
            HStack {
                Text("35 bis 59")
                    .font(Application.UI.Fonts.valueLabel)
                    .foregroundColor(.gray)
                Spacer()
                Text("\(dataStore.provinceIncidence(over: 35, under: 50).count)")
                    .font(Application.UI.Fonts.value)
                    .foregroundColor(Color.color(forIncidence: 36))
            }
            .padding(.horizontal, 10)
            HStack {
                Text("25 bis 35")
                    .font(Application.UI.Fonts.valueLabel)
                    .foregroundColor(.gray)
                Spacer()
                Text("\(dataStore.provinceIncidence(over: 25, under: 35).count)")
                    .font(Application.UI.Fonts.value)
                    .foregroundColor(Color.color(forIncidence: 26))
            }
            .padding(.horizontal, 10)
            HStack {
                Text("kleiner 25")
                    .font(Application.UI.Fonts.valueLabel)
                    .foregroundColor(.gray)
                Spacer()
                Text("\(dataStore.provinceIncidence(under: 25).count)")
                    .font(Application.UI.Fonts.value)
                    .foregroundColor(Color.color(forIncidence: 24))
            }
            .padding(.horizontal, 10)
        }
        .padding(.bottom, 10)
        .background(Color.secondarySystemBackground)
        .cornerRadius(15)
    }
}

struct GermanyProvinceIncidenceView_Previews: PreviewProvider {
    static var previews: some View {
        GermanyProvinceIncidenceView()
    }
}
