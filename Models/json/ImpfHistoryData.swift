//
//  ImpfHistoryData.swift
//  covid19
//
//  Created by Stefan Sturm on 07.01.21.
//

import Foundation

// MARK: - InpfData

struct ImpfHistoryData: Codable {
    
    // MARK: - Feature
    struct Feature: Codable {
        let attributes: ImpfHistoryData.Attributes
    }

    // MARK: - Attributes
    struct Attributes: Codable, Identifiable {
        let id: UUID = UUID()
        
        let bundesland: String
        let impfungenKumulativ: Int?
        let indikationNachAlter: Int?
        let beruflicheIndikation: Int?
        let medizinischeIndikation: Int?
        let pflegeheimbewohnerIn: Int?
        let difference: Int?
        let inzidenz : Double?
        let quote: Double?
        let zweitimpfungenKumulativ: Int?
        let zweitImpDifferenz: Int?
        let impfungenTotal: Int?
        let erstimpfungBiontech: Int?
        let erstimpfungModerna: Int?
        let timestamp: TimeInterval

        enum CodingKeys: String, CodingKey {
            case timestamp = "Datenstand"
            case bundesland = "Bundesland"
            case impfungenKumulativ = "Impfungen_kumulativ"
            case difference = "Differenz_zum_Vortag"
            case zweitimpfungenKumulativ = "Zweitimpfungen_kumulativ"
            case zweitImpDifferenz = "Zweitimp_Differenz_zum_Vortag"
            case impfungenTotal = "Impfungen_Gesamt_Kumulativ"
            case erstimpfungBiontech = "Erstimpfung_Biontech"
            case erstimpfungModerna = "Erstimpfung_Moderna"
            case indikationNachAlter = "Indikation_nach_Alter"
            case beruflicheIndikation = "Berufliche_Indikation"
            case medizinischeIndikation = "Medizinische_Indikation"
            case pflegeheimbewohnerIn = "PflegeheimbewohnerIn"
            case inzidenz = "Impf_Inzidenz"
            case quote = "Impf_Quote"
        }
    }

    let features: [ImpfHistoryData.Feature]

    enum CodingKeys: String, CodingKey {
        case features
    }
}
