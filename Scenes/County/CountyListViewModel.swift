//
//  ListViewModel.swift
//  covid19
//
//  Created by Stefan Sturm on 21.10.20.
//

import Foundation

class CountyListViewModel: NSObject, ObservableObject {
    @Published var isLoading: Bool = false
    @Published var countyListData: [CountyData.Attributes] = []
    @Published var proviceListData: [ProvinceData.Attributes] = []

    private let apiService = APIService()
    
    override init() {
        super.init()
        
        loadCountyData()
        loadProvinceData()
    }
}

extension CountyListViewModel {
    func loadCountyData() {
        guard let url = URL(string: "https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/RKI_Landkreisdaten/FeatureServer/0/query?where=1%3D1&outFields=OBJECTID,GEN,BEZ,EWZ,KFL,death_rate,cases,deaths,cases_per_100k,cases_per_population,BL,BL_ID,county,last_update,cases7_per_100k,recovered,EWZ_BL,cases7_bl_per_100k&returnGeometry=false&outSR=4326&f=json") else {
            return
        }
        
        isLoading = true
        
        apiService.get(url) { (result: Result<CountyData, Error>) in
            switch result {
            case .success(let data):
                self.countyListData = data.features.map { $0.attributes }.sorted(by: {$0.cases7Per100K ?? 0 > $1.cases7Per100K ?? 0})
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func loadProvinceData() {
        guard let url = URL(string: "https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/Coronaf%C3%A4lle_in_den_Bundesl%C3%A4ndern/FeatureServer/0/query?where=1%3D1&outFields=OBJECTID_1,LAN_ew_GEN,Fallzahl,Aktualisierung,faelle_100000_EW,Death,cases7_bl_per_100k&returnGeometry=false&f=json") else {
            return
        }
        
        isLoading = true
        
        apiService.get(url) { (result: Result<ProvinceData, Error>) in
            switch result {
            case .success(let data):
                self.proviceListData = data.features.map { $0.attributes }.sorted(by: {$0.cases7BlPer100K ?? 0 > $1.cases7BlPer100K ?? 0})
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
