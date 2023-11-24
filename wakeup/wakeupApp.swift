//
//  wakeupApp.swift
//  wakeup
//
//  Created by 熊谷知馬 on 2023/11/13.
//

import SwiftUI

@main
struct wakeupApp: App {
    let persistenceController = PersistenceController()
    

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
    
}
