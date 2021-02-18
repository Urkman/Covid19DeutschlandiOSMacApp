//
//  Country.swift
//  covid19
//
//  Created by Stefan Sturm on 22.10.20.
//

import SwiftUI

class Country {
    var population: Int = 0
    var casesNew: Int = 0
    var deathNew: Int = 0
    var cases: Int = 0
    var death: Int = 0
    var recovered: Int = 0
    var vaccinated: Int = 0
    var vaccinatedDifference: Int = 0
    var vaccinatedInzidenz: Double = 0.0
    var vaccinatedQuote: Double = 0.0
    
    var vaccinatedSecond: Int = 0
    var vaccinatedSecondDifference: Int = 0
    var vaccinatedTotal: Int = 0
    var vaccinatedBiontech: Int = 0
    var vaccinatedModerna: Int = 0

    var cases7Per100k: Double = 0
    var casesPer100k: Double = 0

    var bedsTotal: Int = 0
    var bedsUsed: Int = 0
    var bedsCovid: Int = 0
    var bedsCovidVentilate: Int = 0
}

extension Country {
    var casesFormatted: String {
        return NumberFormatter.formatterInteger.string(from: NSNumber(value: cases)) ?? "-"
    }

    var casesActiveFormatted: String {
        return NumberFormatter.formatterInteger.string(from: NSNumber(value: cases - recovered)) ?? "-"
    }

    var casesChangesFormatted: String {
        return NumberFormatter.formatterInteger.string(from: NSNumber(value: casesNew)) ?? "-"
    }

    var deathsFormatted: String {
        return NumberFormatter.formatterInteger.string(from: NSNumber(value: death)) ?? "-"
    }

    var populationFormatted: String {
        return NumberFormatter.formatterInteger.string(from: NSNumber(value: population)) ?? "-"
    }

    var recoveredFormatted: String {
        return NumberFormatter.formatterInteger.string(from: NSNumber(value: recovered)) ?? "-"
    }

    var vaccinatedTotalFormatted: String {
        return NumberFormatter.formatterInteger.string(from: NSNumber(value: vaccinatedTotal)) ?? "-"
    }
    
    var vaccinatedFormatted: String {
        return NumberFormatter.formatterInteger.string(from: NSNumber(value: vaccinated)) ?? "-"
    }

    var vaccinatedDifferenceFormatted: String {
        return NumberFormatter.formatterInteger.string(from: NSNumber(value: vaccinatedDifference)) ?? "-"
    }

    var vaccinatedSecondFormatted: String {
        return NumberFormatter.formatterInteger.string(from: NSNumber(value: vaccinatedSecond)) ?? "-"
    }

    var vaccinatedSeccondDifferenceFormatted: String {
        return NumberFormatter.formatterInteger.string(from: NSNumber(value: vaccinatedSecondDifference)) ?? "-"
    }

    var vaccinatedSecondQuoteFormatted: String {
        guard let valueString = NumberFormatter.formatterDecimal.string(from: NSNumber(value: Double(vaccinatedSecond) / Double(population) * 100))  else { return "-" }
        return "\(valueString)%"
    }

    var vaccinatedInzidenzFormatted: String {
        return NumberFormatter.formatterDecimal.string(from: NSNumber(value: vaccinatedInzidenz)) ?? "-"
    }

    var vaccinatedQuoteFormatted: String {
        guard let valueString = NumberFormatter.formatterDecimal.string(from: NSNumber(value: Double(vaccinated) / Double(population) * 100))  else { return "-" }
        return "\(valueString)%"
    }

    var vaccinatedBiontechFormatted: String {
        return NumberFormatter.formatterInteger.string(from: NSNumber(value: vaccinatedBiontech)) ?? "-"
    }

    var vaccinatedModernaFormatted: String {
        return NumberFormatter.formatterInteger.string(from: NSNumber(value: vaccinatedModerna)) ?? "-"
    }

    var cases7Per100kFormatted: String {
        return NumberFormatter.formatterDecimal.string(from: NSNumber(value: cases7Per100k)) ?? "-"
    }

    var casesPer100kFormatted: String {
        return NumberFormatter.formatterInteger.string(from: NSNumber(value: casesPer100k)) ?? "-"
    }

    var deathsChangesFormatted: String {
        return NumberFormatter.formatterInteger.string(from: NSNumber(value: deathNew)) ?? "-"
    }
    
    var bedsTotalFormatted: String {
        return NumberFormatter.formatterInteger.string(from: NSNumber(value: bedsTotal)) ?? "-"
    }

    var bedsUsedFormatted: String {
        return NumberFormatter.formatterInteger.string(from: NSNumber(value: bedsUsed)) ?? "-"
    }

    var bedsFreeFormatted: String {
        return NumberFormatter.formatterInteger.string(from: NSNumber(value: bedsTotal - bedsUsed)) ?? "-"
    }

    var bedsCovidFormatted: String {
        return NumberFormatter.formatterInteger.string(from: NSNumber(value: bedsCovid)) ?? "-"
    }
    
    var bedsCovidVentilateFormatted: String {
        return NumberFormatter.formatterInteger.string(from: NSNumber(value: bedsCovidVentilate)) ?? "-"
    }
    
    var casesPerPopulationFormatted: String {
        guard let valueString = NumberFormatter.formatterDecimal.string(from: NSNumber(value: Double(cases) / Double(population) * 100))  else { return "-" }
        return "\(valueString)%"
    }

    var deathRateFormatted: String {
        guard let valueString = NumberFormatter.formatterDecimal.string(from: NSNumber(value: Double(death) / Double(cases) * 100))  else { return "-" }
        return "\(valueString)%"
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

extension Country {
    static func snapShot() -> Country {
        let country = Country()
        country.population = 99999999
        country.cases = 999999
        country.death = 99999
        
        return country
    }
}
