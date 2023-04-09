//
//  DashboardApp.swift
//  Dashboard
//
//  Created by Chris Ross on 4/8/23.
//

import SwiftUI

@main
struct DashboardApp: App {
    var netthing = ImageFromNetwork()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(netthing)
        }
    }
}
