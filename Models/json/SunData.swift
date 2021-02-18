//
//  SunData.swift
//  covid19
//
//  Created by Stefan Sturm on 22.10.20.
//

import Foundation

// MARK: - Province
struct SumData: Codable {
    
    // MARK: - Feature
    struct Feature: Codable {
        let attributes: SumData.Attributes
    }

    // MARK: - Attributes
    struct Attributes: Codable, Identifiable {
        let id: UUID = UUID()
        
        let value: Int?
        let county: String?
        let province: String?

        enum CodingKeys: String, CodingKey {
            case value
            case county = "Landkreis"
            case province = "Bundesland"
        }
    }

    let features: [SumData.Feature]

    enum CodingKeys: String, CodingKey {
        case features
    }
}
