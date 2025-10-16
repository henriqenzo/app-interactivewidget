//
//  IncreaseWidgetApp.swift
//  IncreaseWidget
//
//  Created by Enzo Henrique Botelho Romão on 14/10/25.
//

import SwiftUI

@main
struct IncreaseWidgetApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .defaultAppStorage(UserDefaults(suiteName: "group.henriqenzo.widgets")!)
        }
    }
}
