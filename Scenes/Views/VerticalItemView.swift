//
//  VerticalItemView.swift
//  covid19
//
//  Created by Stefan Sturm on 24.10.20.
//

import SwiftUI

struct VerticalItemView: View {
    let leftText: String
    let rightText: String
    var color: Color = Color.label
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text(leftText)
                .font(Application.UI.Fonts.valueLabel)
                .foregroundColor(.secondaryLabel)
            Text(rightText)
                .font(Application.UI.Fonts.value)
                .foregroundColor(color)
        }
    }
}

struct HorizontalItemView: View {
    let leftText: String
    let rightText: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            Text(leftText)
                .font(Application.UI.Fonts.valueLabel)
                .foregroundColor(.secondaryLabel)
            Spacer()
            Text(rightText)
                .font(Application.UI.Fonts.value)
        }
    }
}
