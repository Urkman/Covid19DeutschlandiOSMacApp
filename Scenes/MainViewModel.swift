//
//  MainViewModel.swift
//  covid19
//
//  Created by Stefan Sturm on 20.10.20.
//

import SwiftUI
import CoreLocation
import Combine

class LocationViewModel: NSObject, ObservableObject {
    
    @Published var isLoading: Bool = false
    
    @Published var city: String = ""
    @Published var provinceName: String = ""
    
    @Published var countyData: County.Attributes?
    @Published var provnceData: Province.Attributes?
    
    private let locationManager = CLLocationManager()
    private let apiService = APIService()
    
    var currentLocation: CLLocation? {
        didSet {
            if !isLoading {
                loadCountyData()
            }
        }
    }
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    lazy var formatter: NumberFormatter = {
        let formater = NumberFormatter()
        formater.groupingSeparator = "."
        formater.minimumFractionDigits = 0
        formater.maximumFractionDigits = 1
        formater.numberStyle = .decimal
        
        return formater
    }()
}

extension LocationViewModel {
    var casesCounty: String {
        guard let value = countyData?.cases  else { return "" }
        return formatter.string(from: NSNumber(value: value)) ?? "-"
    }

    var cases7Per100County: String {
        guard let value = countyData?.cases7Per100K  else { return "" }
        return formatter.string(from: NSNumber(value: value)) ?? "-"
    }

    var casesPer100County: String {
        guard let value = countyData?.casesPer100K  else { return "" }
        return formatter.string(from: NSNumber(value: value)) ?? "-"
    }

    var deathCounty: String {
        guard let value = countyData?.deaths  else { return "" }
        return formatter.string(from: NSNumber(value: value)) ?? "-"
    }

    var deathRateCounty: String {
        guard let value = countyData?.deathRate  else { return "" }
        return formatter.string(from: NSNumber(value: value)) ?? "-"
    }

    var casesProvice: String {
        guard let value = provnceData?.cases  else { return "" }
        return formatter.string(from: NSNumber(value: value)) ?? "-"
    }

    var deathProvice: String {
        guard let value = provnceData?.deaths  else { return "" }
        return formatter.string(from: NSNumber(value: value)) ?? "-"
    }

    var einwohnerProvice: String {
        guard let value = countyData?.ewzBl  else { return "" }
        return formatter.string(from: NSNumber(value: value)) ?? "-"
    }

    var cases7Per100Province: String {
        guard let value = provnceData?.cases7BlPer100K  else { return "" }
        return formatter.string(from: NSNumber(value: value)) ?? "-"
    }

    var casesPer100Province: String {
        guard let value = provnceData?.casesPer100K  else { return "" }
        return formatter.string(from: NSNumber(value: value)) ?? "-"
    }
}

extension LocationViewModel {
    func loadCountyData() {
        guard let lat = currentLocation?.coordinate.latitude, let long = currentLocation?.coordinate.longitude else { return }
        
        guard let url = URL(string: "https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/RKI_Landkreisdaten/FeatureServer/0/query?where=1%3D1&outFields=OBJECTID,GEN,county,BL,cases7_per_100k,cases_per_100k,cases,deaths,death_rate,last_update,recovered,cases7_bl_per_100k,EWZ_BL&geometry=\(long),\(lat)&geometryType=esriGeometryPoint&inSR=4326&spatialRel=esriSpatialRelWithin&returnGeometry=false&outSR=4326&f=json") else {
            return
        }
        
        isLoading = true
        
        apiService.get(url) { (result: Result<County, Error>) in
            switch result {
            case .success(let data):
                self.countyData = data.features.first?.attributes
                self.provinceName = self.countyData?.bl ?? ""
                
                self.loadProvinceData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadProvinceData() {
        guard let url = URL(string: "https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/Coronaf%C3%A4lle_in_den_Bundesl%C3%A4ndern/FeatureServer/0/query?where=LAN_ew_GEN%3D%27\(self.provinceName)%27&objectIds&time&geometry&geometryType=esriGeometryEnvelope&inSR&spatialRel=esriSpatialRelIntersects&resultType=none&distance=0.0&units=esriSRUnit_Meter&returnGeodetic=false&outFields=OBJECTID_1,LAN_ew_GEN,faelle_100000_EW,cases7_bl_per_100k,Fallzahl,Death,Aktualisierung&returnGeometry=false&returnCentroid=false&featureEncoding=esriDefault&multipatchOption=none&maxAllowableOffset&geometryPrecision&outSR&datumTransformation&applyVCSProjection=false&returnIdsOnly=false&returnUniqueIdsOnly=false&returnCountOnly=false&returnExtentOnly=false&returnQueryGeometry=false&returnDistinctValues=false&cacheHint=false&orderByFields&groupByFieldsForStatistics&outStatistics&having&resultOffset&resultRecordCount&returnZ=false&returnM=false&returnExceededLimitFeatures=true&quantizationParameters&sqlFormat=none&f=json&token") else {
            return
        }
        
        apiService.get(url) { (result: Result<Province, Error>) in
            self.isLoading = false
            switch result {
            case .success(let data):
                print(data)
                self.provnceData = data.features.first?.attributes
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
}

extension LocationViewModel: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        getPlace(for: location) { placemark in
            self.city = placemark?.locality ?? ""
        }
        
        manager.stopUpdatingLocation()
        currentLocation = location
    }
}

// MARK: - Get Placemark
extension LocationViewModel {
    func getPlace(for location: CLLocation, completion: @escaping (CLPlacemark?) -> Void) {
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            
            guard error == nil else {
                print("*** Error in \(#function): \(error!.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?[0] else {
                print("*** Error in \(#function): placemark is nil")
                completion(nil)
                return
            }
            
            completion(placemark)
        }
    }
}



// MARK: - Get Location
extension LocationViewModel {
    func getLocation(forPlaceCalled name: String, completion: @escaping(CLLocation?) -> Void) {
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(name) { placemarks, error in
            
            guard error == nil else {
                print("*** Error in \(#function): \(error!.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?[0] else {
                print("*** Error in \(#function): placemark is nil")
                completion(nil)
                return
            }
            
            guard let location = placemark.location else {
                print("*** Error in \(#function): placemark is nil")
                completion(nil)
                return
            }
            
            completion(location)
        }
    }
}
