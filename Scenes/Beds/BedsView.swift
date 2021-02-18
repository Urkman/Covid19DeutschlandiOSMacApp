//
//  BedsView.swift
//  covid19
//
//  Created by Stefan Sturm on 02.11.20.
//

import SwiftUI

struct BedsView: View {
    @ObservedObject private var dataStore = DataStore.shared
    @State var selectedProvice: Province?
    
    let columns = [
        GridItem(.adaptive(minimum: 300))
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
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Deutschland")
                            .font(Application.UI.Fonts.header)
                            .padding([.horizontal, .top], 10)
                        
                        HStack {
                            Group {
                                Spacer()
                                VerticalItemView(leftText: "Gesamt", rightText: dataStore.country.bedsTotalFormatted, color: Color.systemYellow)
                                Spacer()
                                VerticalItemView(leftText: "Belegt", rightText: dataStore.country.bedsUsedFormatted, color: Color.systemRed)
                                Spacer()
                                VerticalItemView(leftText: "Frei", rightText: dataStore.country.bedsFreeFormatted, color: Color.systemGreen)
                                Spacer()
                            }
                            VerticalItemView(leftText: "Covid", rightText: dataStore.country.bedsCovidFormatted, color: Color.systemYellow)
                            Spacer()
                            VerticalItemView(leftText: "Beatmet", rightText: dataStore.country.bedsCovidVentilateFormatted, color: Color.systemRed)
                            Spacer()
                        }
                        .padding([.horizontal, .bottom], 10)
                    }
                    .background(Color.secondarySystemBackground)
                    .cornerRadius(15)
                    .padding(.horizontal, 10)
                    .padding([.top], 20)
                    
                    Color.separator
                        .frame(height:1.0)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                    
                    LazyVGrid(columns: columns, alignment: .center) {
                        ForEach(dataStore.provinceList.sorted(by: { $0.bedsTotal > $1.bedsTotal })) { item in
                            ProvinceListBedsItemView(province: item)
                                .onTapGesture {
                                    self.selectedProvice = item
                                }
                                .background(Color.secondarySystemBackground)
                                .cornerRadius(15)
                        }
                    }
                    .padding([.horizontal, .bottom], 10)
                    .sheet(item: self.$selectedProvice) { province in
                        ProvinceDetailsView(province: province)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .navigationBarTitle("Intensivbetten", displayMode: .inline)
    }
}
