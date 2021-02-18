//
//  Location.swift
//  covid19
//
//  Created by Stefan Sturm on 05.11.20.
//

import SwiftUI

class Location: Identifiable {
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
}

extension Location {
    static func snapShot() -> Location {
        let location = Location()
        location.name = "Anrath"
        location.county = "Viersen"
        location.province = "Nordrhein-Westfalen"
        location.population = 99999999
        location.cases = 999999
        location.death = 99999
        
        return location
    }
}
