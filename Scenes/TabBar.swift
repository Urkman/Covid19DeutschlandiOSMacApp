//
//  TabBar.swift
//  covid19
//
//  Created by Stefan Sturm on 11.11.20.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            NavigationView {
                OverviewView()
            }
            .tabItem {
                Image(systemName: "waveform.path.ecg")
                Text("Überblick")
            }

            NavigationView {
                ProvinceListView()
            }
            .tabItem {
                Image(systemName: "list.dash")
                Text("Bundesländer")
            }

            NavigationView {
                CountyListView()
            }
            .tabItem {
                Image(systemName: "list.dash")
                Text("Landkreise")
            }

            NavigationView {
                VaccinationListView()
            }
                .tabItem {
                    Image(systemName: "bandage")
                    Text("Impfungen")
                }

            NavigationView {
                LocationView()
            }
                .tabItem {
                    Image(systemName: "location")
                    Text("Standort")
                }
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
