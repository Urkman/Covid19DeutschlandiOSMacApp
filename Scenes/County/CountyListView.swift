//
//  ListView.swift
//  covid19
//
//  Created by Stefan Sturm on 21.10.20.
//

import SwiftUI

struct CountyListView: View {
    @ObservedObject private var dataStore = DataStore.shared
    
    @State private var searchText = ""
    @State var selectedCounty: County?
    
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
                        SearchBar(text: $searchText)
                            .padding(.horizontal, 10)
                        
                        LazyVGrid(columns: columns, alignment: .center) {
                            ForEach(dataStore.countyList.filter({ searchText.isEmpty ? true : $0.name.lowercased().contains(searchText.lowercased()) })) { item in
                                CountyListItemView(county: item)
                                    .onTapGesture {
                                        self.selectedCounty = item
                                    }
                                    .background(Color.secondarySystemBackground)
                                    .cornerRadius(15)
                            }
                        }
                        .padding(.horizontal, 10)
                        .sheet(item: self.$selectedCounty) { county in
                            if let province = DataStore.shared.province(for: county.province) {
                                CountyDetailsView(county: county, province: province)
                            }
                        }
                    }
                    .padding(.vertical, 10)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .navigationBarTitle("Landkreise", displayMode: .inline)
    }
}
