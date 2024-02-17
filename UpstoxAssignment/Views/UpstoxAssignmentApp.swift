//
//  UpstoxAssignmentApp.swift
//  UpstoxAssignment
//
//  Created by Arrax on 17/02/24.
//

import SwiftUI

@main
struct UpstoxAssignmentApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
