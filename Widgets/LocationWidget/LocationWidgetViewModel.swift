////
////  LocationWidgetViewModel.swift
////  WidgetExtension
////
////  Created by Stefan Sturm on 04.11.20.
////
//
//import SwiftUI
//import CoreLocation
//import Combine
//
//class LocationWidgetViewModel: NSObject, ObservableObject {
//    @Published var isLoading: Bool = false
//
//    @Published var countyData: CountyData.Attributes?
//    @Published var provinceData: ProvinceData.Attributes?
//
//    private let locationManager = CLLocationManager()
//    private let apiService = APIService()
//
//    var currentLocation: CLLocation? {
//        didSet {
//            if !isLoading {
//                loadCountyData()
//            }
//        }
//    }
//
//    override init() {
//        super.init()
//        self.locationManager.delegate = self
//        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        self.locationManager.requestWhenInUseAuthorization()
//        self.locationManager.startUpdatingLocation()
//    }
//
//    lazy var formatter: NumberFormatter = {
//        let formater = NumberFormatter()
//        formater.groupingSeparator = "."
//        formater.minimumFractionDigits = 0
//        formater.maximumFractionDigits = 1
//        formater.numberStyle = .decimal
//
//        return formater
//    }()
//}
//
//extension LocationWidgetViewModel {
//    var casesCounty: String {
//        guard let value = countyData?.cases  else { return "" }
//        return formatter.string(from: NSNumber(value: value)) ?? "-"
//    }
//
//    var cases7Per100County: String {
//        guard let value = countyData?.cases7Per100K  else { return "" }
//        return formatter.string(from: NSNumber(value: value)) ?? "-"
//    }
//
//    var casesPer100County: String {
//        guard let value = countyData?.casesPer100K  else { return "" }
//        return formatter.string(from: NSNumber(value: value)) ?? "-"
//    }
//
//    var deathCounty: String {
//        guard let value = countyData?.deaths  else { return "" }
//        return formatter.string(from: NSNumber(value: value)) ?? "-"
//    }
//
//    var deathRateCounty: String {
//        guard let value = countyData?.deathRate  else { return "" }
//        return formatter.string(from: NSNumber(value: value)) ?? "-"
//    }
//
//    var casesProvice: String {
//        guard let value = provinceData?.cases  else { return "" }
//        return formatter.string(from: NSNumber(value: value)) ?? "-"
//    }
//
//    var deathProvice: String {
//        guard let value = provinceData?.deaths  else { return "" }
//        return formatter.string(from: NSNumber(value: value)) ?? "-"
//    }
//
//    var einwohnerProvice: String {
//        guard let value = countyData?.ewzBl  else { return "" }
//        return formatter.string(from: NSNumber(value: value)) ?? "-"
//    }
//
//    var cases7Per100Province: String {
//        guard let value = provinceData?.cases7BlPer100K  else { return "" }
//        return formatter.string(from: NSNumber(value: value)) ?? "-"
//    }
//
//    var casesPer100Province: String {
//        guard let value = provinceData?.casesPer100K  else { return "" }
//        return formatter.string(from: NSNumber(value: value)) ?? "-"
//    }
//}
//
//extension LocationWidgetViewModel {
//    func loadLocationData(for coordinate: CLLocationCoordinate2D, completion: @escaping (Location) -> Void) {
//        let location = Location()
//
//        completion(location)
//    }
//
//    func loadCountyData() {
//        guard let lat = currentLocation?.coordinate.latitude, let long = currentLocation?.coordinate.longitude else { return }
//
//        guard let url = URL(string: "https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/RKI_Landkreisdaten/FeatureServer/0/query?where=1%3D1&outFields=OBJECTID,GEN,BEZ,EWZ,KFL,death_rate,cases,deaths,cases_per_100k,cases_per_population,BL,BL_ID,county,last_update,cases7_per_100k,recovered,EWZ_BL,cases7_bl_per_100k&geometry=\(long),\(lat)&geometryType=esriGeometryPoint&inSR=4326&spatialRel=esriSpatialRelWithin&returnGeometry=false&outSR=4326&f=json") else {
//            return
//        }
//
//        isLoading = true
//
//        apiService.get(url) { (result: Result<CountyData, Error>) in
//            switch result {
//            case .success(let data):
////                self.countyName = data.features.first?.attributes.county ?? ""
////                self.provinceName = data.features.first?.attributes.bl ?? ""
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//
//            self.isLoading = false
//        }
//    }
//}
//
//// MARK: - Get Placemark
//extension LocationWidgetViewModel {
//    func getPlace(for location: CLLocation, completion: @escaping (CLPlacemark?) -> Void) {
//
//        let geocoder = CLGeocoder()
//        geocoder.reverseGeocodeLocation(location) { placemarks, error in
//
//            guard error == nil else {
//                print("*** Error in \(#function): \(error!.localizedDescription)")
//                completion(nil)
//                return
//            }
//
//            guard let placemark = placemarks?[0] else {
//                print("*** Error in \(#function): placemark is nil")
//                completion(nil)
//                return
//            }
//
//            completion(placemark)
//        }
//    }
//}
