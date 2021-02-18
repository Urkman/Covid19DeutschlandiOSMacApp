//
//  Province.swift
//  covid19
//
//  Created by Stefan Sturm on 22.10.20.
//

import SwiftUI

class Province: Identifiable {
    var id: UUID = UUID()

    var name: String = ""
    var population: Int = 0
    
    var casesNew: Int = 0
    var deathsNew: Int = 0
    var cases: Int = 0
    var deaths: Int = 0
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
    
    var deathRate: Double {
        return 0
    }
    var casesPerPopulation: Double {
        return 0
    }
    
    var bedsTotal: Int = 0
    var bedsUsed: Int = 0
    var bedsCovid: Int = 0
    var bedsCovidVentilate: Int = 0
}

extension Province {
    static func from(data: ProvinceData.Attributes) -> Province {
        let province = Province()
        province.name = data.gen ?? ""
        province.population = data.ewz ?? 0
        province.cases = data.cases ?? 0
        province.deaths = data.deaths ?? 0
        province.casesPer100k = data.casesPer100K ?? 0
        province.cases7Per100k = data.cases7BlPer100K ?? 0
        
        return province
    }
}

extension Province {
    var cases7Per100kFormatted: String {
        return NumberFormatter.formatterDecimal.string(from: NSNumber(value: cases7Per100k)) ?? "-"
    }

    var casesPer100kFormatted: String {
        return NumberFormatter.formatterInteger.string(from: NSNumber(value: casesPer100k)) ?? "-"
    }

    var casesFormatted: String {
        return NumberFormatter.formatterInteger.string(from: NSNumber(value: cases)) ?? "-"
    }

    var casesActiveFormatted: String {
        return NumberFormatter.formatterInteger.string(from: NSNumber(value: cases - recovered)) ?? "-"
    }

    var casesNewFormatted: String {
        return NumberFormatter.formatterInteger.string(from: NSNumber(value: casesNew)) ?? "-"
    }

    var deathsFormatted: String {
        return NumberFormatter.formatterInteger.string(from: NSNumber(value: deaths)) ?? "-"
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

    var deathsNewFormatted: String {
        return NumberFormatter.formatterInteger.string(from: NSNumber(value: deathsNew)) ?? "-"
    }

    var populationFormatted: String {
        return NumberFormatter.formatterInteger.string(from: NSNumber(value: population)) ?? "-"
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

    var casesPerPopulationFormatted: String {
        guard let valueString = NumberFormatter.formatterDecimal.string(from: NSNumber(value: Double(cases) / Double(population) * 100))  else { return "-" }
        return "\(valueString)%"
    }

    var deathRateFormatted: String {
        guard let valueString = NumberFormatter.formatterDecimal.string(from: NSNumber(value: Double(deaths) / Double(cases) * 100))  else { return "-" }
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
    
    var shortName: String {
        
        if name == "Baden-Württemberg" {
          return "BW"
        } else if name == "Bayern" {
            return "BY"
        } else if name == "Berlin" {
            return "BE"
        } else if name == "Brandenburg" {
            return "BB"
        } else if name == "Bremen" {
            return "HB"
        } else if name == "Hamburg" {
            return "HH"
        } else if name == "Hessen" {
            return "HE"
        } else if name == "Mecklenburg-Vorpommern" {
            return "MV"
        } else if name == "Niedersachsen" {
            return "NI"
        } else if name == "Nordrhein-Westfalen" {
            return "NRW"
        } else if name == "Rheinland-Pfalz" {
            return "RP"
        } else if name == "Saarland" {
            return "SL"
        } else if name == "Sachsen" {
            return "SN"
        } else if name == "Sachsen-Anhalt" {
            return "ST"
        } else if name == "Schleswig-Holstein" {
            return "SH"
        } else if name == "Thüringen" {
            return "TH"
        }
        
        return ""
    }
}

extension Province {
    static func snapShot() -> Province {
        let province = Province()
        province.population = 1234567
        province.cases = 123456
        province.deaths = 12345
        
        return province
    }
}
