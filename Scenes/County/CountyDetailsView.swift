//
//  CountyDetailsView.swift
//  covid19
//
//  Created by Stefan Sturm on 22.10.20.
//

import SwiftUI
import SwiftUICharts

struct CountyDetailsView: View {
    var county:County
    var province: Province
    
    @ObservedObject private var dataStore = DataStore.shared

    @State private var chartType = 0
    @State private var chartAmount = 1

    var casesData: [DataPoint] {
        let maxCount = chartAmount == 0 ? 1000 : chartAmount == 1 ? Application.Settings.chartMinValue : Application.Settings.chartMaxValue
        let color = chartType == 0 ? Color.systemYellow : chartType == 1 ? Color.systemRed : Color.systemGreen
        let casesData = dataStore.countyCasesHistoryList.reversed().prefix(maxCount).reversed().map { DataPoint(value: $0.value, label: "", legend: Legend(color: color, label: "", order: 1)) }
        
        return casesData
    }

    var deathsData: [DataPoint] {
        let maxCount = chartAmount == 0 ? 1000 : chartAmount == 1 ? Application.Settings.chartMinValue : Application.Settings.chartMaxValue
        let color = chartType == 0 ? Color.systemYellow : chartType == 1 ? Color.systemRed : Color.systemGreen
        let deathsData = dataStore.countyDeathsHistoryList.reversed().prefix(maxCount).reversed().map { DataPoint(value: $0.value, label: "", legend: Legend(color: color, label: "", order: 2)) }

        return deathsData
    }

    var recoveredData: [DataPoint] {
        let maxCount = chartAmount == 0 ? 1000 : chartAmount == 1 ? Application.Settings.chartMinValue : Application.Settings.chartMaxValue
        let color = chartType == 0 ? Color.systemYellow : chartType == 1 ? Color.systemRed : Color.systemGreen
        let recoveredData = dataStore.countyRecoveredHistoryList.reversed().prefix(maxCount).reversed().map { DataPoint(value: $0.value, label: "", legend: Legend(color: color, label: "", order: 3)) }

        return recoveredData
    }
    
    var cases7100kData:[DataPoint] {
        let maxCount = chartAmount == 0 ? 1000 : chartAmount == 1 ? Application.Settings.chartMinValue : Application.Settings.chartMaxValue

        var values: [DataPoint] = []
        for (index, _) in dataStore.countyCasesHistoryList.enumerated() {
            
            if dataStore.countyCasesHistoryList.indices.contains(index+6) {
                let value = dataStore.countyCasesHistoryList[index...index+6].map { $0.value }.reduce(0, +) / Double(county.population) * 100000
                let color = value > 100 ? Color.darkRed : value > 50 ? Color.systemRed : value > 35 ? Color.systemOrange : value > 25 ? Color.systemYellow : Color.systemGreen
                let dataPoint = DataPoint(value: value, label: "", legend: Legend(color: color, label: "", order: 3))
                values.append(dataPoint)
            }
        }
        
        return values.reversed().prefix(maxCount).reversed().map { $0 }
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color.systemBackground
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        VStack(alignment: .leading, spacing: 20) {
                            HStack {
                                VStack(alignment: .leading, spacing: 0) {
                                    Text("Landkreis")
                                        .font(.headline)
                                        .foregroundColor(.gray)
                                    Text(county.name)
                                        .font(.title)
                                }
                                Spacer()
                                Text(county.cases7Per100kFormatted)
                                    .font(.title)
                                    .foregroundColor(county.color)
                            }
                            .padding([.horizontal, .top], 10)
                            
                            HStack {
                                Group {
                                    Spacer()
                                    VerticalItemView(leftText: "Fälle", rightText: county.casesFormatted, color: Color.systemYellow)
                                    Spacer()
                                    VerticalItemView(leftText: "Neu", rightText: county.casesNewFormatted, color: Color.systemYellow)
                                    Spacer()
                                    VerticalItemView(leftText: "Tote", rightText: county.deathsFormatted, color: Color.systemRed)
                                    Spacer()
                                }
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
                            Text("Intensivbetten")
                                .font(.title3)
                                .padding([.horizontal, .top], 10)
                            
                            HStack {
                                Group {
                                Spacer()
                                    VerticalItemView(leftText: "Gesamt", rightText: county.bedsTotalFormatted, color: Color.systemYellow)
                                Spacer()
                                    VerticalItemView(leftText: "Belegt", rightText: county.bedsUsedFormatted, color: Color.systemRed)
                                Spacer()
                                    VerticalItemView(leftText: "Frei", rightText: county.bedsFreeFormatted, color: Color.systemGreen)
                                Spacer()
                                }
                                VerticalItemView(leftText: "Covid", rightText: county.bedsCovidFormatted, color: Color.systemYellow)
                                Spacer()
                                VerticalItemView(leftText: "Beatmet", rightText: county.bedsCovidVentilateFormatted, color: Color.systemRed)
                                Spacer()
                            }
                            .padding([.horizontal, .bottom], 10)
                        }
                        .background(Color.secondarySystemBackground)
                        .cornerRadius(15)
                        .padding(10)

                        VStack(alignment: .leading, spacing: 15) {
                            HStack(alignment: .center, spacing: 20) {
                                Text("Verlauf")
                                    .font(.title3)
                                
                                Picker(selection: $chartAmount, label: Text("")) {
                                    Text("\(Application.Settings.chartMinValue) Tage").tag(1)
                                    Text("\(Application.Settings.chartMaxValue) Tage").tag(2)
                                    Text("Alle").tag(0)
                                }.pickerStyle(SegmentedPickerStyle())
                            }
                            .padding([.horizontal, .top], 10)
                            .padding(.bottom, 10)

                            BarChartView(dataPoints: chartType == 0 ? casesData : chartType == 1 ? deathsData: chartType == 2 ? recoveredData : cases7100kData)
                                .frame(maxWidth: UIScreen.main.bounds.width - 70, maxHeight: 150)
                                .padding(.horizontal, 10)
                            
                            Picker(selection: $chartType, label: Text("")) {
                                Text("Fälle").tag(0)
                                Text("Tote").tag(1)
                                Text("Genesen").tag(2)
                                Text("Inzidenz").tag(3)
                            }.pickerStyle(SegmentedPickerStyle())
                            .padding([.horizontal, .bottom], 10)
                        }
                        .chartStyle(BarChartStyle(axisLeadingPadding: 5.0, gridColor: Color.label, showLegends: false, barsCornerRadius: Application.Settings.chartRoundedCorner, barsCorners: [.topLeft, .topRight]))
                        .background(Color.secondarySystemBackground)
                        .cornerRadius(15)
                        .padding(10)

                        VStack(alignment: .leading, spacing: 20) {
                            HStack {
                                VStack(alignment: .leading, spacing: 0) {
                                    Text("Bundesland")
                                        .font(.headline)
                                        .foregroundColor(.gray)
                                    Text(province.name)
                                        .font(.title)
                                }
                                Spacer()
                                Text(province.cases7Per100kFormatted)
                                    .font(.title)
                                    .foregroundColor(province.color)
                            }
                            .padding([.horizontal, .top], 10)

                            HStack {
                                Spacer()
                                VerticalItemView(leftText: "Fälle", rightText: province.casesFormatted)
                                Spacer()
                                VerticalItemView(leftText: "Neu", rightText: province.casesNewFormatted)
                                Spacer()
                                VerticalItemView(leftText: "Tote", rightText: province.deathsFormatted)
                                Spacer()
                                VerticalItemView(leftText: "Neu", rightText: province.deathsNewFormatted)
                                Spacer()
                            }
                            .padding(.horizontal, 10)
                            
                            VStack(alignment: .leading, spacing: 5) {
                                HorizontalItemView(leftText: "Einwohner", rightText: province.populationFormatted)
                                HorizontalItemView(leftText: "Fälle pro 100.000 Einwohner", rightText: province.casesPer100kFormatted)
                                HorizontalItemView(leftText: "Infektionsrate", rightText: province.casesPerPopulationFormatted)
                                HorizontalItemView(leftText: "Totesrate", rightText: province.deathRateFormatted)
                            }
                            .padding([.horizontal, .bottom], 10)

                            Spacer()
                        }
                        .background(Color.secondarySystemBackground)
                        .cornerRadius(15)
                        .padding(10)
                        
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .navigationBarTitle(county.name, displayMode: .inline)
        }
        .onAppear{
            dataStore.loadData(for: county)
        }
    }
}
