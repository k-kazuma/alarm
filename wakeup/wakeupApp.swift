//
//  wakeupApp.swift
//  wakeup
//
//  Created by 熊谷知馬 on 2023/11/13.
//

/*

 ・実装済
 初回起動時：通知許可の要求と起床、就寝時間を入力。
 次回以降起動時：起床時刻までの時間表示、設定ボタンを表示
 
 ・未実装
 通知の処理・・・　音、スヌーズ、画面消灯している時の通知
 天気・・・　トップ画面に今日の天気、気温を表示する
 
*/
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
