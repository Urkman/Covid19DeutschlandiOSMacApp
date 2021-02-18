//
//  NumberFormatter+Extension.swift
//  covid19
//
//  Created by Stefan Sturm on 21.10.20.
//

import Foundation


extension NumberFormatter {
    static var formatterDecimal: NumberFormatter = {
        let formater = NumberFormatter()
        formater.groupingSeparator = "."
        formater.minimumFractionDigits = 1
        formater.maximumFractionDigits = 1
        formater.numberStyle = .decimal
        
        return formater
    }()

    static var formatterDecimal3Fractions: NumberFormatter = {
        let formater = NumberFormatter()
        formater.groupingSeparator = "."
        formater.minimumFractionDigits = 1
        formater.maximumFractionDigits = 3
        formater.numberStyle = .decimal
        
        return formater
    }()

    static var formatterInteger: NumberFormatter = {
        let formater = NumberFormatter()
        formater.groupingSeparator = "."
        formater.minimumFractionDigits = 0
        formater.maximumFractionDigits = 0
        formater.numberStyle = .decimal

        return formater
    }()

}
