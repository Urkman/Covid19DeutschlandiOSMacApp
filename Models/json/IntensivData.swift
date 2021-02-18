//
//  IntensivData.swift
//  covid19
//
//  Created by Stefan Sturm on 22.10.20.
//

import Foundation

// MARK: - IntensivData
struct IntensivData: Codable {
    
    // MARK: - Feature
    struct Feature: Codable {
        let attributes: IntensivData.Attributes
    }

    // MARK: - Attributes
    struct Attributes: Codable, Identifiable {
        let id: UUID = UUID()
        
        let objectid: Int?
        let bl, blId, county, updated: String?
        let anzahlStandorte: Int?
        let bedsFree, bedsUsed, bedsTotal: Int?
        let bedsCovid, bedsCovidVentilate: Int?

        enum CodingKeys: String, CodingKey {
            case objectid = "OBJECTID"
            case bl = "BL"
            case blId = "BL_ID"
            case county
            case anzahlStandorte = "anzahl_standorte"
            case bedsFree = "betten_frei"
            case bedsUsed = "betten_belegt"
            case bedsTotal = "betten_gesamt"
            case bedsCovid = "faelle_covid_aktuell"
            case bedsCovidVentilate = "faelle_covid_aktuell_beatmet"
            case updated = "daten_stand"
        }
    }

    let features: [IntensivData.Feature]

    enum CodingKeys: String, CodingKey {
        case features
    }
}
