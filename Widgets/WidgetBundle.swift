//
//  WidgetBundle.swift
//  covid19
//
//  Created by Stefan Sturm on 03.11.20.
//

import SwiftUI
import WidgetKit

@main
struct Widgets: WidgetBundle {
    
    @WidgetBundleBuilder
    var body: some Widget {
        CountryWidget()
        LocationWidget()
    }
}
