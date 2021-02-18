//
//  MainView.swift
//  covid19
//
//  Created by Stefan Sturm on 20.10.20.
//

import SwiftUI

struct MainView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    @ViewBuilder
    var body: some View {
        if horizontalSizeClass == .compact {
            TabBar()
        } else {
            Sidebar()
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
