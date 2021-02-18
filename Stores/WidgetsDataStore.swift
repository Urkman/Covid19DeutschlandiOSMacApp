//
//  WidgetsDataStore.swift
//  covid19
//
//  Created by Stefan Sturm on 01.11.20.
//

import Foundation

class WidgetsDataStore {
    static let shared = WidgetsDataStore()

    private var proviceData: [ProvinceData.Attributes] = []
    private var globalCasesChanges: Int?
    private var globalDeathChanges: Int?
    
    private var countryCasesHistoryList: [CaseHistory] = []
    private var casesHistoryData: [CasesHistoryData.Attributes] = []

    private let apiService = APIService()
}

extension WidgetsDataStore {
    func loadCountryData(completion: @escaping (Country) -> ()) {
        let dispatchGroup = DispatchGroup()

        if let provinceUrl = URL(string: Application.Urls.provinceListUrl) {
            dispatchGroup.enter()
            apiService.get(provinceUrl) { (result: Result<ProvinceData, Error>) in
                switch result {
                case .success(let data):
                    self.proviceData = data.features.map { $0.attributes }.sorted(by: {$0.cases7BlPer100K ?? 0 > $1.cases7BlPer100K ?? 0})
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                DispatchQueue.main.async {
                    dispatchGroup.leave()
                }
            }
        }

        if let globalCasesUrl = URL(string: Application.Urls.globalCasesUrl) {
            dispatchGroup.enter()
            apiService.get(globalCasesUrl) { (result: Result<SumData, Error>) in
                switch result {
                case .success(let data):
                    self.globalCasesChanges = data.features.first?.attributes.value ?? -1
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                DispatchQueue.main.async {
                    dispatchGroup.leave()
                }
            }
        }

        if let globalDeathUrl = URL(string: Application.Urls.globalDeathUrl) {
            dispatchGroup.enter()
            apiService.get(globalDeathUrl) { (result: Result<SumData, Error>) in
                switch result {
                case .success(let data):
                    self.globalDeathChanges = data.features.first?.attributes.value ?? -1
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                DispatchQueue.main.async {
                    dispatchGroup.leave()
                }
            }
        }
        
        if let url = URL(string: Application.Urls.globalCasesHistoryUrl) {
            dispatchGroup.enter()
            apiService.get(url) { (result: Result<CasesHistoryData, Error>) in
                switch result {
                case .success(let data):
                    self.casesHistoryData = data.features.map { $0.attributes }
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                DispatchQueue.main.async {
                    dispatchGroup.leave()
                }
            }
        }

        dispatchGroup.notify(queue: .main) {
            let country = Country()
            country.population = self.proviceData.map { $0.ewz ?? 0 }.reduce(0, +)
            country.cases = self.proviceData.map { $0.cases ?? 0 }.reduce(0, +)
            country.death = self.proviceData.map { $0.deaths ?? 0 }.reduce(0, +)
//            country.recovered = provinceRecoveredData.map { $0.value ?? 0 }.reduce(0, +)
            country.deathNew = self.globalDeathChanges ?? 0
            country.casesNew = self.globalCasesChanges ?? 0

            for item in self.casesHistoryData {
                self.countryCasesHistoryList.append(CaseHistory.from(data: item))
            }

            if self.countryCasesHistoryList.indices.contains(6) {
                country.cases7Per100k = self.countryCasesHistoryList.reversed()[0...6].map { $0.value }.reduce(0, +) / Double(country.population) * 100000
            }

            completion(country)
        }
    }
}
