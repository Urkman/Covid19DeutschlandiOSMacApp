//
//  LocationView.swift
//  covid19
//
//  Created by Stefan Sturm on 20.10.20.
//

import SwiftUI

struct LocationView: View {
    @ObservedObject private var viewModel = LocationViewModel()
    @ObservedObject private var dataStore = DataStore.shared
    
    @State var selectedCounty: County?
    @State var selectedProvince: Province?
    
    var body: some View {
        ZStack {
            Color.systemBackground
                .ignoresSafeArea()
            
            if viewModel.isLoading {
                VStack {
                    ProgressView()
                        .frame(width: 100, height: 100)
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5, anchor: .center)
                }
            } else if let county = dataStore.county(for: viewModel.countyName), let province = dataStore.province(for: viewModel.provinceName) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        VStack(alignment: .leading, spacing: 20) {
                            HStack {
                                VStack(alignment: .leading, spacing: 0) {
                                    Text("Stadt")
                                        .font(.system(size: 16))
                                        .foregroundColor(.gray)
                                    Text(viewModel.cityName)
                                        .font(.system(size: 18))
                                    HStack {
                                        Text("Landkreis")
                                            .font(.system(size: 16))
                                            .foregroundColor(.gray)
                                        Text(county.name)
                                            .font(.system(size: 18))
                                    }.padding(.top, 10)
                                }
                                Spacer()
                                Text(county.cases7Per100kFormatted)
                                    .font(.system(size: 20))
                                    .foregroundColor(county.color)
                            }
                            .padding([.horizontal, .top], 10)
                            .onTapGesture {
                                self.selectedCounty = county
                            }
                            .sheet(item: self.$selectedCounty) { county in
                                CountyDetailsView(county: county, province: province)
                            }
                            
                            HStack {
                                Group {
                                    Spacer()
                                    VerticalItemView(leftText: "Fälle", rightText: county.casesFormatted, color: Color.systemYellow)
                                    Spacer()
                                    VerticalItemView(leftText: "Neu", rightText: county.casesNewFormatted, color: Color.systemYellow)
                                    Spacer()
                                    VerticalItemView(leftText: "Tote", rightText: county.deathsFormatted, color: Color.systemRed)
                                }
                                Spacer()
                                VerticalItemView(leftText: "Neu", rightText: county.deathsNewFormatted, color: Color.systemRed)
                                Spacer()
                                VerticalItemView(leftText: "Genesen", rightText: county.recoveredFormatted, color: Color.systemGreen)
                                Spacer()
                            }
                            .padding(.horizontal, 10)
                            
                            VStack(alignment: .leading, spacing: 15) {
                                HorizontalItemView(leftText: "Einwohner", rightText: county.populationFormatted)
                                HorizontalItemView(leftText: "Fälle pro 100.000 Einwohner", rightText: county.casesPer100kFormatted)
                                HorizontalItemView(leftText: "Infektionsrate", rightText: county.casesPerPopulationFormatted)
                                HorizontalItemView(leftText: "Totesrate", rightText: county.deathRateFormatted)
                            }
                            .padding([.horizontal, .bottom], 10)
                        }
                        .background(Color.secondarySystemBackground)
                        .cornerRadius(15)
                        .padding(10)
                        
                        VStack(alignment: .leading, spacing: 20) {
                            HStack {
                                VStack(alignment: .leading, spacing: 0) {
                                    Text("Bundesland")
                                        .font(.system(size: 16))
                                        .foregroundColor(.gray)
                                    Text(province.name)
                                        .font(.system(size: 18))
                                }
                                Spacer()
                                Text(province.cases7Per100kFormatted)
                                    .font(.system(size: 20))
                                    .foregroundColor(province.color)
                            }
                            .padding([.horizontal, .top], 10)
                            .onTapGesture {
                                self.selectedProvince = province
                            }
                            .sheet(item: self.$selectedProvince) { province in
                                ProvinceDetailsView(province: province)
                            }
                            
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
                            
                            VStack(alignment: .leading, spacing: 15) {
                                HorizontalItemView(leftText: "Einwohner", rightText: province.populationFormatted)
                                HorizontalItemView(leftText: "Fälle pro 100.000 Einwohner", rightText: province.casesPer100kFormatted)
                                HorizontalItemView(leftText: "Infektionsrate", rightText: province.casesPerPopulationFormatted)
                                HorizontalItemView(leftText: "Totesrate", rightText: province.deathRateFormatted)
                            }
                            .padding([.horizontal, .bottom], 10)
                        }
                        .background(Color.secondarySystemBackground)
                        .cornerRadius(15)
                        .padding(10)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .navigationBarTitle("Aktueller Standort", displayMode: .inline)
        .navigationBarItems(trailing:
                                Button(action: {
                                    self.viewModel.relocate()
                                }) {
                                    Image(systemName: "arrow.clockwise").renderingMode(.template)
                                })
    }
}
