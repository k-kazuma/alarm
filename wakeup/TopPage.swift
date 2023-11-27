//
//  TopPage.swift
//  wakeup
//
//  Created by 熊谷知馬 on 2023/11/24.
//

import SwiftUI
import CoreData

struct TopPage: View {
    @Binding var userData: UserData
   
    
    var body: some View {
        
        VStack{
            Text("起床時刻\(userData.wakeUpTime)")
            Text("就寝時刻\(userData.bedTime)")
        }
        
        if !userData.permission {
            Text("通知が許可されていません。このアプリを利用するには通知を許可して下さい。")
            Button("設定画面を開く"){
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }
        }

    }
}
