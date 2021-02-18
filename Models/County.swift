//
//  County.swift
//  covid19
//
//  Created by Stefan Sturm on 22.10.20.
//

import SwiftUI

class County: Identifiable {
    var id: UUID = UUID()

    var name: String = ""
    var county: String = ""

    var province: String = ""
    var population: Int = 0
    
    var casesNew: Int = 0
    var deathNew: Int = 0
    var cases: Int = 0
    var death: Int = 0
    var recovered: Int = 0

    var cases7Per100k: Double = 0
    var casesPer100k: Double = 0
    var deathRate: Double = 0
    var casesPerPopulation: Double = 0
    
    var bedsTotal: Int = 0
    var bedsUsed: Int = 0
    var bedsCovid: Int = 0
    var bedsCovidVentilate: Int = 0
}

extension County {
    static func from(data: CountyData.Attributes) -> County {
        let county = County()
        county.name = data.gen ?? ""
        county.county = data.county ?? ""
        county.province = data.bl ?? ""
        county.population = data.ewz ?? 0
        county.cases = data.cases ?? 0
        county.death = data.deaths ?? 0
        county.casesPer100k = data.casesPer100K ?? 0
        county.cases7Per100k = data.cases7Per100K ?? 0
        county.deathRate = data.deathRate ?? 0
        county.casesPerPopulation = data.casesPerPopulation ?? 0
        
        return county
    }
}

extension County {
    var cases7Per100kFormatted: String {
        return NumberFormatter.formatterDecimal.string(from: NSNumber(value: cases7Per100k)) ?? "-"
    }

    var casesPer100kFormatted: String {
        return NumberFormatter.formatterDecimal.string(from: NSNumber(value: casesPer100k)) ?? "-"
    }

    var casesFormatted: String {
        return NumberFormatter.formatterInteger.string(from: NSNumber(value: cases)) ?? "-"
    }

    var recoveredFormatted: String {
        return NumberFormatter.formatterInteger.string(from: NSNumber(value: recovered)) ?? "-"
    }

    var casesNewFormatted: String {
        return NumberFormatter.formatterInteger.string(from: NSNumber(value: casesNew)) ?? "-"
    }

    var deathsFormatted: String {
        return NumberFormatter.formatterInteger.string(from: NSNumber(value: death)) ?? "-"
    }

    var deathsNewFormatted: String {
        return NumberFormatter.formatterInteger.string(from: NSNumber(value: deathNew)) ?? "-"
    }
    
    var populationFormatted: String {
        return NumberFormatter.formatterInteger.string(from: NSNumber(value: population)) ?? "-"
    }

    var casesPerPopulationFormatted: String {
        guard let valueString = NumberFormatter.formatterDecimal.string(from: NSNumber(value: casesPerPopulation))  else { return "-" }
        return "\(valueString)%"
    }

    var deathRateFormatted: String {
        guard let valueString = NumberFormatter.formatterDecimal.string(from: NSNumber(value: deathRate))  else { return "-" }
        return "\(valueString)%"
    }
    
    var bedsTotalFormatted: String {
        return NumberFormatter.formatterInteger.string(from: NSNumber(value: bedsTotal)) ?? "-"
    }

    var bedsUsedFormatted: String {
        return NumberFormatter.formatterInteger.string(from: NSNumber(value: bedsUsed)) ?? "-"
    }
    
    var bedsCovidFormatted: String {
        return NumberFormatter.formatterInteger.string(from: NSNumber(value: bedsCovid)) ?? "-"
    }
    
    var bedsCovidVentilateFormatted: String {
        return NumberFormatter.formatterInteger.string(from: NSNumber(value: bedsCovidVentilate)) ?? "-"
    }

    var bedsFreeFormatted: String {
        return NumberFormatter.formatterInteger.string(from: NSNumber(value: bedsTotal - bedsUsed)) ?? "-"
    }

    var color: Color {
        if cases7Per100k < 25 {
            return Color.systemGreen
        } else if cases7Per100k < 35 {
            return Color.systemYellow
        } else if cases7Per100k < 50 {
            return Color.systemOrange
        } else if cases7Per100k < 100 {
            return Color.systemRed
        }
        
        return Color.darkRed
    }
}

