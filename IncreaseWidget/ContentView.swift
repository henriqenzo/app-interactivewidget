//
//  ContentView.swift
//  IncreaseWidget
//
//  Created by Enzo Henrique Botelho Romão on 14/10/25.
//

import SwiftUI
import WidgetKit

struct ContentView: View {
    @AppStorage("count") var count = 0
    @AppStorage("selectedColor") var selectedColorId = "Gray"
    
    var selectedColor: WidgetColor {
        WidgetColor.allColors.first(where: { $0.id == selectedColorId }) ?? WidgetColor.allColors[0]
    }
    
    var body: some View {
        ZStack {
            selectedColor.lightColor
                .ignoresSafeArea(edges: .all)
            
            VStack(spacing: 32) {
                Text("Counter")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                Text("\(count)")
                    .font(.system(size: 60))
                    .foregroundStyle(.black)
                
                HStack(spacing: 50) {
                    Spacer()
                    
                    Button(action: {
                        count += 1
                        WidgetCenter.shared.reloadAllTimelines()
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(Color.white)
                            .font(.system(size: 34, weight: .bold))
                            .frame(width: 80, height: 80)
                            .background(selectedColor.color)
                            .cornerRadius(40)
                    }
                    .shadow(color: selectedColor.color.opacity(0.8), radius: 5)
                    .sensoryFeedback(.increase, trigger: count)
                    
                    Button(action: {
                        count = 0
                        WidgetCenter.shared.reloadAllTimelines()
                    }) {
                        Image(systemName: "arrow.trianglehead.counterclockwise")
                            .foregroundColor(Color.white)
                            .font(.system(size: 34, weight: .bold))
                            .frame(width: 80, height: 80)
                            .background(.black.opacity(0.2))
                            .cornerRadius(40)
                    }
                    .shadow(color: .black.opacity(0.4), radius: 5)
                    .sensoryFeedback(.decrease, trigger: count)
                    
                    Spacer()
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
