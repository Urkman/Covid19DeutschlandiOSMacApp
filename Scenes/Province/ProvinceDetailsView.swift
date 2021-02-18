//
//  ProvinceDetailsView.swift
//  covid19
//
//  Created by Stefan Sturm on 22.10.20.
//

import SwiftUI
import SwiftUICharts

struct ProvinceDetailsView: View {
    var province: Province
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    @ObservedObject private var dataStore = DataStore.shared
    
    let columns = [
        GridItem(.adaptive(minimum: 350)),
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.systemBackground
                    .ignoresSafeArea()
                
                ScrollView {
                    if horizontalSizeClass == .compact {
                        VStack(alignment: .leading, spacing: 15) {
                            ProvinceItemView(province: province)
                                .padding(.horizontal, 10)

                            ProvinceVaccinatedView(province: province)
                                .padding(.horizontal, 10)

                            ProvinceBedsItemView(province: province)
                                .padding(.horizontal, 10)


                            ProvinceCharItemView(province: province)
                                .padding(.horizontal, 10)

                            Color.separator
                                .frame(height:1.0)
                                .padding(.horizontal, 20)
                            
                            LazyVGrid(columns: columns) {
                                ForEach(dataStore.countyList.filter({ $0.province == province.name })) { item in
                                    CountyListItemView(county: item)
                                }
                                .background(Color.secondarySystemBackground)
                                .cornerRadius(15)
                            }
                            .padding([.horizontal, .bottom], 10)
                        }
                        .padding(.top, 10)
                        
                    } else {
                        VStack(alignment: .leading, spacing: 0) {
                            HStack {
                                VStack(alignment: .leading, spacing: 15) {
                                    ProvinceItemView(province: province)
                                    ProvinceVaccinatedView(province: province)
                                    ProvinceBedsItemView(province: province)
                                }
                                
                                ProvinceCharItemView(province: province)
                            }
                            .padding(.horizontal, 10)
                            
                            Color.separator
                                .frame(height:1.0)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                            
                            LazyVGrid(columns: columns) {
                                ForEach(dataStore.countyList.filter({ $0.province == province.name })) { item in
                                    CountyListItemView(county: item)
                                }
                                .background(Color.secondarySystemBackground)
                                .cornerRadius(15)
                            }
                            .padding([.horizontal, .bottom], 10)
                        }
                        .padding(.top, 10)
                    }
                }
                .frame(maxWidth: .infinity)
                .navigationBarTitle(province.name, displayMode: .inline)
                .navigationBarItems(trailing:
                                        Button(action: {
                                            withAnimation {
                                                self.presentationMode.wrappedValue.dismiss()
                                            }
                                        }) {
                                            Image(systemName: "xmark")
                                        })
            }
            .onAppear{
                dataStore.loadData(for: province)
            }
        }
    }
}
