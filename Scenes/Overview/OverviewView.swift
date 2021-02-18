//
//  OverviewView.swift
//  covid19
//
//  Created by Stefan Sturm on 20.10.20.
//

import SwiftUI
import SwiftUICharts

struct OverviewView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @ObservedObject private var dataStore = DataStore.shared
    
    let columns = [
        GridItem(.adaptive(minimum: 350)),
    ]
    
    var body: some View {
        ZStack {
            Color.systemBackground
                .ignoresSafeArea()
            
            if dataStore.isLoading {
                VStack {
                    ProgressView()
                        .frame(width: 100, height: 100)
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5, anchor: .center)
                }
            } else {
                ScrollView {
                    if horizontalSizeClass == .compact {
                        VStack(alignment: .leading, spacing: 15) {
                            GermanyItemView()
                                .padding(.horizontal, 10)
                            
                            GermanyVaccinatedView()
                                .padding(.horizontal, 10)
                            
                            GermanyBedsItemView()
                                .padding(.horizontal, 10)
                            
                            GermanyChartItemView()
                                .frame(height: 250)
                                .padding(.horizontal, 10)
                            
                            GermanyProvinceIncidenceView()
                                .padding(.horizontal, 10)
                            
                            GermanyCountyIncidenceView()
                                .padding(.horizontal, 10)
                        }
                        .padding(.vertical, 10)
                    } else {
                        VStack(alignment: .leading, spacing: 15) {
                            GermanyItemView()
                                .padding(.horizontal, 10)
                            
                            HStack {
                                GermanyVaccinatedView()
                                GermanyBedsItemView()
                            }
                            .padding(.horizontal, 10)
                            
                            GermanyChartItemView()
                                .frame(height: 300)
                                .padding(.horizontal, 10)
                            
                            HStack {
                                GermanyProvinceIncidenceView()
                                GermanyCountyIncidenceView()
                            }
                            .padding(.horizontal, 10)
                        }
                        .padding(.vertical, 10)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .navigationBarTitle("Überblick", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            self.dataStore.loadData()
        }) {
            Image(systemName: "arrow.clockwise")
        })
    }
}

extension Color {
    static func color(forIncidence incidence: Double) -> Color {
        if incidence < 25 {
            return Color.systemGreen
        } else if incidence < 35 {
            return Color.systemYellow
        } else if incidence < 50 {
            return Color.systemOrange
        } else if incidence < 100 {
            return Color.systemRed
        }
        
        return Color.darkRed
    }
    
}
