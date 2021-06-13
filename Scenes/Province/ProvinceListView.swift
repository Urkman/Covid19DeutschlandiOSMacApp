//
//  ProvinceListView.swift
//  covid19
//
//  Created by Stefan Sturm on 13.02.21.
//

import SwiftUI

struct ProvinceListView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @ObservedObject private var dataStore = DataStore.shared
    @State var selectedProvice: Province?
    
    let columns = [
        GridItem(.adaptive(minimum: 300))
    ]
    
    var body: some View {
        ZStack {
            Color.background
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
                            LazyVGrid(columns: columns, alignment: .center) {
                                ForEach(dataStore.provinceList) { item in
                                    ProvinceListItemView(province: item, showVaccination: false)
                                        .onTapGesture {
                                            self.selectedProvice = item
                                        }
                                        .background(Color.cardBackground)
                                        .cornerRadius(15)
                                }
                            }
                            .padding(.horizontal, 10)
                        }
                        .padding(.vertical, 10)
                        .sheet(item: self.$selectedProvice) { province in
                            ProvinceDetailsView(province: province)
                        }
                    } else {
                        VStack(alignment: .leading, spacing: 15) {
                            LazyVGrid(columns: columns) {
                                ForEach(dataStore.provinceList) { item in
                                    ProvinceListItemView(province: item, showVaccination: false)
                                        .onTapGesture {
                                            self.selectedProvice = item
                                        }
                                        .background(Color.cardBackground)
                                        .cornerRadius(15)
                                }
                            }
                            .fullScreenCover(item: self.$selectedProvice) { province in
                                ProvinceDetailsView(province: province)
                            }
                            .padding(.horizontal, 10)
                        }
                        .padding(.vertical, 10)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .navigationBarTitle("Bundesländer", displayMode: .inline)
    }
}
