//
//  GermanyCharItemView.swift
//  covid19
//
//  Created by Stefan Sturm on 11.11.20.
//

import SwiftUI
import SwiftUICharts

struct GermanyChartItemView: View {
    @ObservedObject private var dataStore = DataStore.shared
    
    @State private var chartType = 0
    @State private var chartAmount = 1
    
    var casesData: [DataPoint] {
        let maxCount = chartAmount == 0 ? 1000 : chartAmount == 1 ? 8 : chartAmount == 2 ? 15 : chartAmount == 3 ? 30 : chartAmount == 4 ? 45 : 60
        let color = Color.systemYellow
        let casesData = dataStore.countryCasesHistoryList.reversed().prefix(maxCount).reversed().map { DataPoint(value: $0.value, label: "", legend: Legend(color: color, label: "", order: 1)) }
        
        return casesData
    }
    
    var deathsData: [DataPoint] {
        let maxCount = chartAmount == 0 ? 1000 : chartAmount == 1 ? 8 : chartAmount == 2 ? 15 : chartAmount == 3 ? 30 : chartAmount == 4 ? 45 : 60
        let color = Color.systemRed
        let deathsData = dataStore.countryDeathsHistoryList.reversed().prefix(maxCount).reversed().map { DataPoint(value: $0.value, label: "", legend: Legend(color: color, label: "", order: 2)) }
        
        return deathsData
    }
    
    var vaccinatedData: [DataPoint] {
        let maxCount = chartAmount == 0 ? 1000 : chartAmount == 1 ? 8 : chartAmount == 2 ? 15 : chartAmount == 3 ? 30 : chartAmount == 4 ? 45 : 60
        let color = Color.systemGreen
        let recoveredData = dataStore.countryVaccinatedHistoryList.reversed().prefix(maxCount).reversed().map { DataPoint(value: $0, label: "", legend: Legend(color: color, label: "", order: 3)) }
        
        return recoveredData
    }
    
    var cases7100kData:[DataPoint] {
        let maxCount = chartAmount == 0 ? 1000 : chartAmount == 1 ? 8 : chartAmount == 2 ? 15 : chartAmount == 3 ? 30 : chartAmount == 4 ? 45 : 60
        
        var values: [DataPoint] = []
        for (index, _) in dataStore.countryCasesHistoryList.enumerated() {
            
            if dataStore.countryCasesHistoryList.indices.contains(index+6) {
                let value = dataStore.countryCasesHistoryList[index...index+6].map { $0.value }.reduce(0, +) / Double(dataStore.country.population) * 100000
                
                let color = value > 100 ? Color.darkRed : value > 50 ? Color.systemRed : value > 35 ? Color.systemOrange : value > 25 ? Color.systemYellow : Color.systemGreen
                
                let dataPoint = DataPoint(value: value, label: "", legend: Legend(color: color, label: "", order: 3))
                values.append(dataPoint)
            }
        }
        
        return values.reversed().prefix(maxCount).reversed().map { $0 }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(alignment: .center, spacing: 20) {
                Text("Verlauf")
                    .font(Application.UI.Fonts.header)
                
                Picker(selection: $chartAmount, label: Text("")) {
                    Text("8").tag(1)
                    Text("15").tag(2)
                    Text("30").tag(3)
                    Text("45").tag(4)
                    Text("60").tag(5)
                    Text("Alle").tag(0)
                }.pickerStyle(SegmentedPickerStyle())
            }
            .padding(.horizontal, 10)
            .padding([.bottom, .top], 10)
            
            BarChartView(dataPoints: chartType == 0 ? casesData : chartType == 1 ? deathsData: chartType == 2 ?  cases7100kData : vaccinatedData)
                .padding(.horizontal, 10)
            
            Picker(selection: $chartType, label: Text("")) {
                Text("Fälle").tag(0)
                Text("Tote").tag(1)
                Text("Inzidenz").tag(2)
                Text("Impfungen").tag(3)
            }.pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal, 10)
            .padding(.bottom, 10)
        }
        .chartStyle(BarChartStyle(showAxis: false, gridColor: Color.label, showLegends: false, barsCornerRadius: Application.Settings.chartRoundedCorner, barsCorners: [.topLeft, .topRight]))
        .background(Color.secondarySystemBackground)
        .cornerRadius(15)
    }
}
