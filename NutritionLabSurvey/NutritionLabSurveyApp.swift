//
//  NutritionLabSurveyApp.swift
//  NutritionLabSurvey
//
//  Created by Scott Mueller on 2/15/21.
//

import SwiftUI

@main
struct NutritionLabSurveyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
