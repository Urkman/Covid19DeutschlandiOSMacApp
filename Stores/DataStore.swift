//
//  DataStore.swift
//  covid19
//
//  Created by Stefan Sturm on 21.10.20.
//

import Foundation

class DataStore: ObservableObject {
    static let shared = DataStore()
    
    @Published var country: Country = Country()
    
    @Published var countryCasesHistoryList: [CaseHistory] = []
    @Published var countryDeathsHistoryList: [CaseHistory] = []
    @Published var countryRecoveredHistoryList: [CaseHistory] = []
    @Published var countryVaccinatedHistoryList: [Double] = []

    @Published var countyList: [County] = []
    @Published var countyCasesHistoryList: [CaseHistory] = []
    @Published var countyDeathsHistoryList: [CaseHistory] = []
    @Published var countyRecoveredHistoryList: [CaseHistory] = []

    @Published var provinceList: [Province] = []
    @Published var provinceCasesHistoryList: [CaseHistory] = []
    @Published var provinceDeathsHistoryList: [CaseHistory] = []
    @Published var provinceRecoveredHistoryList: [CaseHistory] = []
    @Published var provinceVaccinatedHistoryList: [Double] = []

    @Published var isLoading: Bool = false

    // Data
    private var countyData: [CountyData.Attributes] = []
    private var proviceData: [ProvinceData.Attributes] = []
    private var intensivData: [IntensivData.Attributes] = []

    private var globalCasesChanges: Int?
    private var globalDeathChanges: Int?

    private var casesHistoryData: [CasesHistoryData.Attributes] = []
    private var deathsHistoryData: [CasesHistoryData.Attributes] = []
    private var recoveredHistoryData: [CasesHistoryData.Attributes] = []
    private var countyCasesHistoryData: [CasesHistoryData.Attributes] = []
    private var countyDeathsHistoryData: [CasesHistoryData.Attributes] = []
    private var countyRecoveredHistoryData: [CasesHistoryData.Attributes] = []
    private var provinceCasesHistoryData: [CasesHistoryData.Attributes] = []
    private var provinceDeathsHistoryData: [CasesHistoryData.Attributes] = []
    private var provinceRecoveredHistoryData: [CasesHistoryData.Attributes] = []
    private var impfHistoryData: [ImpfHistoryData.Attributes] = []

    private var countyCasesData: [SumData.Attributes] = []
    private var countyDeathsData: [SumData.Attributes] = []
    private var countyRecoveredData: [SumData.Attributes] = []
    
    private var provinceCasesData: [SumData.Attributes] = []
    private var provinceDeathsData: [SumData.Attributes] = []
    private var provinceRecoveredData: [SumData.Attributes] = []

    
    private let apiService = APIService()    
}

extension DataStore {
    func loadData() {
        guard isLoading == false else { return }
        
        // reset data
        country = Country()
        provinceList = []
        countyList = []
        countryCasesHistoryList = []
        countryDeathsHistoryList = []
        
        countyData = []
        proviceData = []
        globalCasesChanges = 0
        globalDeathChanges = 0
        
        isLoading = true
        let dispatchGroup = DispatchGroup()
        
        if let countyUrl = URL(string: Application.Urls.countyListUrl) {
            dispatchGroup.enter()
            apiService.get(countyUrl) { (result: Result<CountyData, Error>) in
                switch result {
                case .success(let data):
                    self.countyData = data.features.map { $0.attributes }.sorted(by: {$0.cases7Per100K ?? 0 > $1.cases7Per100K ?? 0})
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                DispatchQueue.main.async {
                    dispatchGroup.leave()
                }
            }
        }
        
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

        if let url = URL(string: Application.Urls.globalIntensivListUrl) {
            dispatchGroup.enter()
            apiService.get(url) { (result: Result<IntensivData, Error>) in
                switch result {
                case .success(let data):
                    self.intensivData = data.features.map { $0.attributes }
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

        if let url = URL(string: Application.Urls.countyCasesUrl) {
            dispatchGroup.enter()
            apiService.get(url) { (result: Result<SumData, Error>) in
                switch result {
                case .success(let data):
                    self.countyCasesData = data.features.map { $0.attributes }
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                DispatchQueue.main.async {
                    dispatchGroup.leave()
                }
            }
        }

        if let url = URL(string: Application.Urls.countyDeathUrl) {
            dispatchGroup.enter()
            apiService.get(url) { (result: Result<SumData, Error>) in
                switch result {
                case .success(let data):
                    self.countyDeathsData = data.features.map { $0.attributes }
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                DispatchQueue.main.async {
                    dispatchGroup.leave()
                }
            }
        }

        if let url = URL(string: Application.Urls.proviceCasesUrl) {
            dispatchGroup.enter()
            apiService.get(url) { (result: Result<SumData, Error>) in
                switch result {
                case .success(let data):
                    self.provinceCasesData = data.features.map { $0.attributes }
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                DispatchQueue.main.async {
                    dispatchGroup.leave()
                }
            }
        }

        if let url = URL(string: Application.Urls.proviceDeathUrl) {
            dispatchGroup.enter()
            apiService.get(url) { (result: Result<SumData, Error>) in
                switch result {
                case .success(let data):
                    self.provinceDeathsData = data.features.map { $0.attributes }
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

        if let url = URL(string: Application.Urls.globalDeathsHistoryUrl) {
            dispatchGroup.enter()
            apiService.get(url) { (result: Result<CasesHistoryData, Error>) in
                switch result {
                case .success(let data):
                    self.deathsHistoryData = data.features.map { $0.attributes }
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                DispatchQueue.main.async {
                    dispatchGroup.leave()
                }
            }
        }

        if let url = URL(string: Application.Urls.globalRecoveredHistoryUrl) {
            dispatchGroup.enter()
            apiService.get(url) { (result: Result<CasesHistoryData, Error>) in
                switch result {
                case .success(let data):
                    self.recoveredHistoryData = data.features.map { $0.attributes }
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                DispatchQueue.main.async {
                    dispatchGroup.leave()
                }
            }
        }

        if let url = URL(string: Application.Urls.provinceRecoveredUrl) {
            dispatchGroup.enter()
            apiService.get(url) { (result: Result<SumData, Error>) in
                switch result {
                case .success(let data):
                    self.provinceRecoveredData = data.features.map { $0.attributes }
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                DispatchQueue.main.async {
                    dispatchGroup.leave()
                }
            }
        }

        if let url = URL(string: Application.Urls.countyRecoveredUrl) {
            dispatchGroup.enter()
            apiService.get(url) { (result: Result<SumData, Error>) in
                switch result {
                case .success(let data):
                    self.countyRecoveredData = data.features.map { $0.attributes }
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                DispatchQueue.main.async {
                    dispatchGroup.leave()
                }
            }
        }
        
        if let url = URL(string: Application.Urls.impfHistoryUrl) {
            dispatchGroup.enter()
            apiService.get(url) { (result: Result<ImpfHistoryData, Error>) in
                switch result {
                case .success(let data):
                    self.impfHistoryData = data.features.map { $0.attributes }
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                DispatchQueue.main.async {
                    dispatchGroup.leave()
                }
            }
        }

        dispatchGroup.notify(queue: .main) {
            self.prepareData()
            self.isLoading = false
        }
    }
    
    func loadData(for province: Province){
        guard isLoading == false else { return }
        
        provinceCasesHistoryList = []
        provinceDeathsHistoryList = []
        provinceRecoveredHistoryList = []
        provinceVaccinatedHistoryList = []
        
//        isLoading = true
        let dispatchGroup = DispatchGroup()

        
        if let name = province.name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed), let url = URL(string: Application.Urls.provinceCasesHistoryUrl.replacingOccurrences(of: "%@", with: name)) {
            dispatchGroup.enter()
            apiService.get(url) { (result: Result<CasesHistoryData, Error>) in
                switch result {
                case .success(let data):
                    self.provinceCasesHistoryData = data.features.map { $0.attributes }
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                DispatchQueue.main.async {
                    dispatchGroup.leave()
                }
            }
        }

        if let name = province.name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed), let url = URL(string: Application.Urls.provinceDeathsHistoryUrl.replacingOccurrences(of: "%@", with: name)) {
            dispatchGroup.enter()
            apiService.get(url) { (result: Result<CasesHistoryData, Error>) in
                switch result {
                case .success(let data):
                    self.provinceDeathsHistoryData = data.features.map { $0.attributes }
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                DispatchQueue.main.async {
                    dispatchGroup.leave()
                }
            }
        }

        if let name = province.name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed), let url = URL(string: Application.Urls.provinceRecoveredHistoryUrl.replacingOccurrences(of: "%@", with: name)) {
            dispatchGroup.enter()
            apiService.get(url) { (result: Result<CasesHistoryData, Error>) in
                switch result {
                case .success(let data):
                    self.provinceRecoveredHistoryData = data.features.map { $0.attributes }
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                DispatchQueue.main.async {
                    dispatchGroup.leave()
                }
            }
        }

        dispatchGroup.notify(queue: .main) {
            for item in self.provinceCasesHistoryData {
                self.provinceCasesHistoryList.append(CaseHistory.from(data: item))
            }

            for item in self.provinceDeathsHistoryData {
                self.provinceDeathsHistoryList.append(CaseHistory.from(data: item))
            }

            for item in self.provinceRecoveredHistoryData {
                self.provinceRecoveredHistoryList.append(CaseHistory.from(data: item))
            }

            for item in self.impfHistoryData.filter({ $0.bundesland == province.name }) {
                let impfValue = Double(item.impfungenKumulativ ?? 0) + Double(item.zweitimpfungenKumulativ ?? 0)
                if self.provinceVaccinatedHistoryList.count == 0 {
                    self.provinceVaccinatedHistoryList.append(impfValue)
                } else {
                    let sum = self.provinceVaccinatedHistoryList.reduce(0, +)
                    self.provinceVaccinatedHistoryList.append(impfValue - sum)
                }
            }

//            self.isLoading = false
        }
    }
    
    func loadData(for county: County){
        guard isLoading == false else { return }
        
        countyCasesHistoryList = []
        countyDeathsHistoryList = []
        countyRecoveredHistoryList = []
        
//        isLoading = true
        let dispatchGroup = DispatchGroup()

        
        if let name = county.county.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed), let url = URL(string: Application.Urls.countyCasesHistoryUrl.replacingOccurrences(of: "%@", with: name)) {
            dispatchGroup.enter()
            apiService.get(url) { (result: Result<CasesHistoryData, Error>) in
                switch result {
                case .success(let data):
                    self.countyCasesHistoryData = data.features.map { $0.attributes }
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                DispatchQueue.main.async {
                    dispatchGroup.leave()
                }
            }
        }

        if let name = county.county.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed), let url = URL(string: Application.Urls.countyDeathsHistoryUrl.replacingOccurrences(of: "%@", with: name)) {
            dispatchGroup.enter()
            apiService.get(url) { (result: Result<CasesHistoryData, Error>) in
                switch result {
                case .success(let data):
                    self.countyDeathsHistoryData = data.features.map { $0.attributes }
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                DispatchQueue.main.async {
                    dispatchGroup.leave()
                }
            }
        }

        if let name = county.county.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed), let url = URL(string: Application.Urls.countyRecoveredHistoryUrl.replacingOccurrences(of: "%@", with: name)) {
            dispatchGroup.enter()
            apiService.get(url) { (result: Result<CasesHistoryData, Error>) in
                switch result {
                case .success(let data):
                    self.countyRecoveredHistoryData = data.features.map { $0.attributes }
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                DispatchQueue.main.async {
                    dispatchGroup.leave()
                }
            }
        }

        dispatchGroup.notify(queue: .main) {
            var casesListData: [CaseHistory] = []
            var deathsListData: [CaseHistory] = []
            var recoveredListData: [CaseHistory] = []

            for item in self.countyCasesHistoryData {
                casesListData.append(CaseHistory.from(data: item))
            }

            for item in self.countyDeathsHistoryData {
                deathsListData.append(CaseHistory.from(data: item))
            }

            for item in self.countyRecoveredHistoryData {
                recoveredListData.append(CaseHistory.from(data: item))
            }

            self.countyCasesHistoryList = casesListData
            self.countyDeathsHistoryList = deathsListData
            self.countyRecoveredHistoryList = recoveredListData
//            self.isLoading = false
        }
    }
}

extension DataStore {
    func province(for name: String) -> Province? {
        return provinceList.filter {$0.name == name}.first
    }

    func county(for name: String) -> County? {
        return countyList.filter {$0.county == name}.first
    }

    private func prepareData() {
        country.population = proviceData.map { $0.ewz ?? 0 }.reduce(0, +)
        country.bedsCovid = intensivData.map { $0.bedsCovid ?? 0 }.reduce(0, +)
        country.bedsTotal = intensivData.map { $0.bedsTotal ?? 0 }.reduce(0, +)
        country.bedsUsed = intensivData.map { $0.bedsUsed ?? 0 }.reduce(0, +)
        country.bedsCovidVentilate = intensivData.map { $0.bedsCovidVentilate ?? 0 }.reduce(0, +)
        country.cases = proviceData.map { $0.cases ?? 0 }.reduce(0, +)
        country.death = proviceData.map { $0.deaths ?? 0 }.reduce(0, +)
        country.recovered = provinceRecoveredData.map { $0.value ?? 0 }.reduce(0, +)
        country.deathNew = globalDeathChanges ?? 0
        country.casesNew = globalCasesChanges ?? 0
        country.casesPer100k = Double(country.cases) / Double(country.population) * 100000
        
        for item in proviceData {
            let province = Province.from(data: item)
            province.bedsCovid = intensivData.filter {$0.bl == province.name}.map { $0.bedsCovid ?? 0 }.reduce(0, +)
            province.bedsTotal = intensivData.filter {$0.bl == province.name}.map { $0.bedsTotal ?? 0 }.reduce(0, +)
            province.bedsUsed = intensivData.filter {$0.bl == province.name}.map { $0.bedsUsed ?? 0 }.reduce(0, +)
            province.bedsCovidVentilate = intensivData.filter {$0.bl == province.name}.map { $0.bedsCovidVentilate ?? 0 }.reduce(0, +)
            province.vaccinated = impfHistoryData.filter {$0.bundesland == province.name}.last?.impfungenKumulativ ?? 0
            province.vaccinatedDifference = impfHistoryData.filter {$0.bundesland == province.name}.last?.difference ?? 0
            province.vaccinatedInzidenz = impfHistoryData.filter {$0.bundesland == province.name}.last?.inzidenz ?? 0.0
            province.vaccinatedQuote = impfHistoryData.filter {$0.bundesland == province.name}.last?.quote ?? 0.0
            province.vaccinatedTotal = impfHistoryData.filter {$0.bundesland == province.name}.last?.impfungenTotal ?? 0
            province.vaccinatedSecond = impfHistoryData.filter {$0.bundesland == province.name}.last?.zweitimpfungenKumulativ ?? 0
            province.vaccinatedSecondDifference = impfHistoryData.filter {$0.bundesland == province.name}.last?.zweitImpDifferenz ?? 0
            province.vaccinatedBiontech = impfHistoryData.filter {$0.bundesland == province.name}.last?.erstimpfungBiontech ?? 0
            province.vaccinatedModerna = impfHistoryData.filter {$0.bundesland == province.name}.last?.erstimpfungModerna ?? 0

            provinceList.append(province)
        }
        
        for item in countyData {
            let county = County.from(data: item)
            county.bedsCovid = intensivData.filter {$0.county == county.county}.map { $0.bedsCovid ?? 0 }.reduce(0, +)
            county.bedsTotal = intensivData.filter {$0.county == county.county}.map { $0.bedsTotal ?? 0 }.reduce(0, +)
            county.bedsUsed = intensivData.filter {$0.county == county.county}.map { $0.bedsUsed ?? 0 }.reduce(0, +)
            county.bedsCovidVentilate = intensivData.filter {$0.county == county.county}.map { $0.bedsCovidVentilate ?? 0 }.reduce(0, +)

            countyList.append(county)
        }
        
        for item in countyCasesData {
            if let countyString = item.county, let county = county(for: countyString) {
                county.casesNew = item.value ?? 0
            }
        }

        for item in countyDeathsData {
            if let countyString = item.county, let county = county(for: countyString) {
                county.deathNew = item.value ?? 0
            }
        }

        for item in countyRecoveredData {
            if let countyString = item.county, let county = county(for: countyString) {
                county.recovered = item.value ?? 0
            }
        }

        for item in provinceCasesData {
            if let provinceString = item.province, let province = province(for: provinceString) {
                province.casesNew = item.value ?? 0
            }
        }

        for item in provinceDeathsData {
            if let provinceString = item.province, let province = province(for: provinceString) {
                province.deathsNew = item.value ?? 0
            }
        }

        for item in provinceRecoveredData {
            if let provinceString = item.province, let province = province(for: provinceString) {
                province.recovered = item.value ?? 0
            }
        }

        for item in casesHistoryData {
            countryCasesHistoryList.append(CaseHistory.from(data: item))
        }
        
        for item in deathsHistoryData {
            countryDeathsHistoryList.append(CaseHistory.from(data: item))
        }

        for item in recoveredHistoryData {
            countryRecoveredHistoryList.append(CaseHistory.from(data: item))
        }
        
        for item in self.impfHistoryData.filter({ $0.bundesland == "Gesamt" }) {
            let impfValue = Double(item.impfungenKumulativ ?? 0) + Double(item.zweitimpfungenKumulativ ?? 0)
            if self.countryVaccinatedHistoryList.count == 0 {
                self.countryVaccinatedHistoryList.append(impfValue)
            } else {
                let sum = self.countryVaccinatedHistoryList.reduce(0, +)
                self.countryVaccinatedHistoryList.append(impfValue - sum)
            }
        }

        if countryCasesHistoryList.indices.contains(6) {
            country.cases7Per100k = countryCasesHistoryList.reversed()[0...6].map { $0.value }.reduce(0, +) / Double(country.population) * 100000
        }
        
        country.vaccinated = impfHistoryData.filter {$0.bundesland == "Gesamt"}.last?.impfungenKumulativ ?? 0
        country.vaccinatedDifference = impfHistoryData.filter {$0.bundesland == "Gesamt"}.last?.difference ?? 0
        country.vaccinatedInzidenz = impfHistoryData.filter {$0.bundesland == "Gesamt"}.last?.inzidenz ?? 0.0
        country.vaccinatedQuote = impfHistoryData.filter {$0.bundesland == "Gesamt"}.last?.quote ?? 0.0
        country.vaccinatedTotal = impfHistoryData.filter {$0.bundesland == "Gesamt"}.last?.impfungenTotal ?? 0
        country.vaccinatedSecond = impfHistoryData.filter {$0.bundesland == "Gesamt"}.last?.zweitimpfungenKumulativ ?? 0
        country.vaccinatedSecondDifference = impfHistoryData.filter {$0.bundesland == "Gesamt"}.last?.zweitImpDifferenz ?? 0
        country.vaccinatedBiontech = impfHistoryData.filter {$0.bundesland == "Gesamt"}.last?.erstimpfungBiontech ?? 0
        country.vaccinatedModerna = impfHistoryData.filter {$0.bundesland == "Gesamt"}.last?.erstimpfungModerna ?? 0
    }
    
    func provinceIncidence(over: Double = 0, under: Double = 10000) -> [Province] {
        return provinceList.filter {$0.cases7Per100k >= over && $0.cases7Per100k < under}
    }
    
    func countyIncidence(over: Double = 0, under: Double = 10000) -> [County] {
        return countyList.filter {$0.cases7Per100k >= over && $0.cases7Per100k < under}
    }
}
