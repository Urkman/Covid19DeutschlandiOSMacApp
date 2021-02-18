//
//  CasesHistory.swift
//  covid19
//
//  Created by Stefan Sturm on 23.10.20.
//

import Foundation

// MARK: - IntensivData
struct CasesHistoryData: Codable {
    
    // MARK: - Feature
    struct Feature: Codable {
        let attributes: CasesHistoryData.Attributes
    }

    // MARK: - Attributes
    struct Attributes: Codable, Identifiable {
        let id: UUID = UUID()
        
        let value: Double
        let timestamp: TimeInterval

        enum CodingKeys: String, CodingKey {
            case value = "total"
            case timestamp = "Meldedatum"
        }
    }

    let features: [CasesHistoryData.Feature]

    enum CodingKeys: String, CodingKey {
        case features
    }
}
