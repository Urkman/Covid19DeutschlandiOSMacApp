//
//  Province.swift
//  covid19
//
//  Created by Stefan Sturm on 20.10.20.
//

import Foundation

// MARK: - Province
struct ProvinceData: Codable {
    
    // MARK: - Feature
    struct Feature: Codable {
        let attributes: ProvinceData.Attributes
    }

    // MARK: - Attributes
    struct Attributes: Codable, Identifiable {
        let id: UUID = UUID()
        
        let objectid: Int?
        let gen: String?
        let casesPer100K: Double?
        let cases, deaths, ewz: Int?
        let lastUpdate: Int?
        let cases7BlPer100K: Double?
        
        enum CodingKeys: String, CodingKey {
            case objectid = "OBJECTID_1"
            case gen = "LAN_ew_GEN"
            case ewz = "LAN_ew_EWZ"
            case casesPer100K = "faelle_100000_EW"
            case cases = "Fallzahl"
            case deaths = "Death"
            case lastUpdate = "Aktualisierung"
            case cases7BlPer100K = "cases7_bl_per_100k"
        }
    }

    let features: [ProvinceData.Feature]

    enum CodingKeys: String, CodingKey {
        case features
    }
}
