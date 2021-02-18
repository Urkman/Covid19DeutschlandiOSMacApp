//
//  CaseHistory.swift
//  covid19
//
//  Created by Stefan Sturm on 23.10.20.
//

import Foundation

class CaseHistory: Identifiable {
    var id: UUID = UUID()
    var value: Double
    var date: Date
    
    init(value: Double, date: Date) {
        self.value = value
        self.date = date
    }
}

extension CaseHistory {
    static func from(data: CasesHistoryData.Attributes) -> CaseHistory {
        let date = Date(timeIntervalSince1970: data.timestamp / 1000)
        
        return CaseHistory(value: data.value, date: date)
    }
    
    static func from(data: ImpfHistoryData.Attributes) -> CaseHistory {
        let date = Date(timeIntervalSince1970: data.timestamp / 1000)
        
        let value = Double(data.impfungenKumulativ ?? 0) + Double(data.zweitimpfungenKumulativ ?? 0)
        return CaseHistory(value: Double(value), date: date)
    }
}
