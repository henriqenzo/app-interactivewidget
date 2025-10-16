//
//  ColorIntent.swift
//  IncreaseWidget
//
//  Created by Enzo Henrique Botelho Romão on 15/10/25.
//

import WidgetKit
import AppIntents
import SwiftUI

struct WidgetColor: AppEntity {
    var id: String
    var lightColor: Color
    var color: Color
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation { "Widget Color" }
    static var defaultQuery = WidgetColorQuery()
    
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(id)")
    }
    
    static let allColors: [WidgetColor] = [
        .init(id: "Gray", lightColor: .lightGray, color: .black.opacity(0.5)),
        .init(id: "Blue", lightColor: .lightBlue, color: .blue),
        .init(id: "Red", lightColor: .lightRed, color: .red),
        .init(id: "Green", lightColor: .lightGreen, color: .green),
        .init(id: "Yellow", lightColor: .lightYellow, color: .yellow),
        .init(id: "Purple", lightColor: .lightPurple, color: .purple),
        .init(id: "Cyan", lightColor: .lightCyan, color: .cyan),
        .init(id: "Pink", lightColor: .lightPink, color: .pink)
    ]
}

struct WidgetColorQuery: EntityQuery {
    func entities(for identifiers: [WidgetColor.ID]) async throws -> [WidgetColor] {
        WidgetColor.allColors.filter { identifiers.contains($0.id) }
    }
    
    func suggestedEntities() async throws -> [WidgetColor] {
        WidgetColor.allColors
    }
    
    func defaultResult() async -> WidgetColor? {
        WidgetColor.allColors.first
    }
}

struct SelectColorIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource { "Widget Accent Color" }
    static var description: IntentDescription { "Select Widget Accent Color" }

    @Parameter(title: "Accent Color")
    var accentColor: WidgetColor?
}
