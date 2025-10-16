//
//  AppIntent.swift
//  Widget
//
//  Created by Enzo Henrique Botelho Romão on 14/10/25.
//

import WidgetKit
import AppIntents
import SwiftUI

struct IncreaseCountIntent: AppIntent {
    static var title = LocalizedStringResource("Increase Count")
    
    func perform() async throws -> some IntentResult {
        if let store = UserDefaults(suiteName: "group.henriqenzo.widgets") {
            let count = store.integer(forKey: "count")
            store.setValue(count + 1, forKey: "count")
            return .result()
        }
        
        return .result()
    }
}

struct SetCountIntent: AppIntent {
    static var title = LocalizedStringResource("Set Count")
    
    @Parameter(title: "Value") var value: Int
    
    init() {
        self.value = 0
    }
    
    init(value: Int) {
        self.value = value
    }
    
    func perform() async throws -> some IntentResult {
        if let store = UserDefaults(suiteName: "group.henriqenzo.widgets") {
            store.setValue(value, forKey: "count")
            return .result()
        }
        
        return .result()
    }
}
