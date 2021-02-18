//
//  Sidebar.swift
//  covid19
//
//  Created by Stefan Sturm on 11.11.20.
//

import SwiftUI

struct Sidebar: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: OverviewView()) {
                    Label("Überblick", systemImage: "waveform.path.ecg")
                }
                NavigationLink(destination: ProvinceListView()) {
                    Label("Bundesländer", systemImage: "list.dash")
                }
                NavigationLink(destination: CountyListView()) {
                    Label("Landkreise", systemImage: "list.dash")
                }
                NavigationLink(destination: LocationView()) {
                    Label("Standort", systemImage: "location")
                }
                NavigationLink(destination: VaccinationListView()) {
                    Label("Impfungen", systemImage: "bandage")
                }
                NavigationLink(destination: BedsView()) {
                    Label("Intensivbetten", systemImage: "bed.double")
                }
            }
            .navigationTitle("")
            
            OverviewView()
        }
    }
}
