//
//  ProvinceCharItemView.swift
//  covid19
//
//  Created by Stefan Sturm on 17.11.20.
//

import SwiftUI
import SwiftUICharts

struct ProvinceCharItemView: View {
    var province: Province
    
    @ObservedObject private var dataStore = DataStore.shared

    @State private var chartType = 0
    @State private var chartAmount = 1

    var casesData: [DataPoint] {
        let maxCount = chartAmount == 0 ? 1000 : chartAmount == 1 ? 15 : chartAmount == 2 ? 30 : 60
        let color = Color.systemYellow
        let casesData = dataStore.provinceCasesHistoryList.reversed().prefix(maxCount).reversed().map { DataPoint(value: $0.value, label: "", legend: Legend(color: color, label: "", order: 1)) }
        
        return casesData
    }

    var deathsData: [DataPoint] {
        let maxCount = chartAmount == 0 ? 1000 : chartAmount == 1 ? 15 : chartAmount == 2 ? 30 : 60
        let color = Color.systemRed
        let deathsData = dataStore.provinceDeathsHistoryList.reversed().prefix(maxCount).reversed().map { DataPoint(value: $0.value, label: "", legend: Legend(color: color, label: "", order: 2)) }

        return deathsData
    }

    var vaccinatedData: [DataPoint] {
        let maxCount = chartAmount == 0 ? 1000 : chartAmount == 1 ? 15 : chartAmount == 2 ? 30 : 60
        let color = Color.systemGreen
        let recoveredData = dataStore.provinceVaccinatedHistoryList.reversed().prefix(maxCount).reversed().map { DataPoint(value: $0, label: "", legend: Legend(color: color, label: "", order: 3)) }

        return recoveredData
    }

    var cases7100kData:[DataPoint] {
        let maxCount = chartAmount == 0 ? 1000 : chartAmount == 1 ? 15 : chartAmount == 2 ? 30 : 60

        var values: [DataPoint] = []
        for (index, _) in dataStore.provinceCasesHistoryList.enumerated() {
            
            if dataStore.provinceCasesHistoryList.indices.contains(index+6) {
                let value = dataStore.provinceCasesHistoryList[index...index+6].map { $0.value }.reduce(0, +) / Double(province.population) * 100000
                let color = value > 100 ? Color.darkRed : value > 50 ? Color.systemRed : value > 35 ? Color.systemOrange : value > 25 ? Color.systemYellow : Color.systemGreen
                let dataPoint = DataPoint(value: value, label: "", legend: Legend(color: color, label: "", order: 3))
                values.append(dataPoint)
            }
        }
        
        return values.reversed().prefix(maxCount).reversed().map { $0 }
    }

    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(alignment: .center, spacing: 20) {
                Text("Verlauf")
                    .font(.title3)
                
                Picker(selection: $chartAmount, label: Text("")) {
                    Text("15").tag(1)
                    Text("30").tag(2)
                    Text("60").tag(3)
                    Text("Alle").tag(0)
                }.pickerStyle(SegmentedPickerStyle())
            }
            .padding([.horizontal, .top], 10)
            .padding(.bottom, 10)

            BarChartView(dataPoints: chartType == 0 ? casesData : chartType == 1 ? deathsData: chartType == 2 ? cases7100kData : vaccinatedData)
                .frame(maxWidth: UIScreen.main.bounds.width - 70)
                .padding(.horizontal, 10)
            
            Picker(selection: $chartType, label: Text("")) {
                Text("Fälle").tag(0)
                Text("Tote").tag(1)
                Text("Inzidenz").tag(2)
            }.pickerStyle(SegmentedPickerStyle())
            .padding([.horizontal, .bottom], 10)
        }
        .chartStyle(BarChartStyle(showAxis: false, gridColor: Color.label, showLegends: false, barsCornerRadius: Application.Settings.chartRoundedCorner, barsCorners: [.topLeft, .topRight]))
        .background(Color.cardBackground)
        .cornerRadius(15)
    }
}
