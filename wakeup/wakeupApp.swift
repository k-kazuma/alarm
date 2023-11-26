//
//  wakeupApp.swift
//  wakeup
//
//  Created by 熊谷知馬 on 2023/11/13.
//


//通知処理作成中。ContentViewマウント時に通知許可ステータスによっての条件分岐を作成中

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
    
