//
//  Covid.swift
//  covid19
//
//  Created by Stefan Sturm on 20.10.20.
//

import Foundation

// MARK: - County
struct CountyData: Codable {
    
    // MARK: - Feature
    struct Feature: Codable {
        let attributes: CountyData.Attributes
    }

    // MARK: - Attributes
    struct Attributes: Codable, Identifiable {
        var id: UUID = UUID()
        
        let objectid: Int?
        let gen, county, bl, bez, blId, ags: String?
        let cases7Per100K, casesPer100K, casesPerPopulation: Double?
        let cases, deaths, ewz: Int?
        let deathRate, kfl: Double?
        let lastUpdate: String?
        let recovered: Double?
        let cases7BlPer100K: Double?
        let ewzBl: Int?
        
        enum CodingKeys: String, CodingKey {
            case objectid = "OBJECTID"
            case gen = "GEN"
            case bez = "BEZ"
            case ewz = "EWZ"
            case kfl = "KFL"
            case ags = "AGS"
            case county
            case bl = "BL"
            case blId = "BL_ID"
            case cases7Per100K = "cases7_per_100k"
            case casesPer100K = "cases_per_100k"
            case casesPerPopulation = "cases_per_population"
            case cases, deaths
            case deathRate = "death_rate"
            case lastUpdate = "last_update"
            case recovered
            case cases7BlPer100K = "cases7_bl_per_100k"
            case ewzBl = "EWZ_BL"
        }
    }

    let features: [CountyData.Feature]

    enum CodingKeys: String, CodingKey {
        case features
    }
}
