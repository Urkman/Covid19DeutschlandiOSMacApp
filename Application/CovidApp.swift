//
//  CovidApp.swift
//  covid19
//
//  Created by Stefan Sturm on 20.10.20.
//

import SwiftUI

@main
struct CovidApp: App {
    init() {
        DataStore.shared.loadData()
        
        UINavigationBar.appearance().tintColor = UIColor.label
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                    print("didBecomeActiveNotification")
                    DataStore.shared.loadData()
                }
        }
    }
}
