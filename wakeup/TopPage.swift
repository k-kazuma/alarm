//
//  TopPage.swift
//  wakeup
//
//  Created by 熊谷知馬 on 2023/11/24.
//

import SwiftUI
import CoreData

struct TopPage: View {
    let calender = Calendar.current
    
    @Binding var userData: UserData
    @State var nowTime = Date()
    @State var hour:Int = 0
    @State var minute:Int = 0
    @State var second:Int = 0
    @State var dispTime = ""
    @State var wakeUpTime: Int = 0
    
    
    var body: some View {
        
        NavigationView{
            VStack{
                Text("起床時刻\(userData.wakeUpTime == "" ? userData.wakeUpTime : timeConversion2(second: Int(userData.wakeUpTime)!))")
                Text("就寝時刻\(userData.bedTime == "" ? userData.bedTime : timeConversion2(second: Int(userData.bedTime)!))")
                Text(dispTime)
                
                NavigationLink(destination: Setting(userData: $userData)){
                    Text("設定")
                }
                
                
                
            }
        }
        .onAppear() {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                //現在の日時を取得し時、分、秒それぞれ格納する
                self.nowTime = Date()
                self.hour = calender.component(.hour, from: nowTime)
                self.minute = calender.component(.minute, from: nowTime)
                self.second = calender.component(.second, from: nowTime)
                
                //現在時刻を秒数に変換
                let nowTime = timeConversion(hour: self.hour, minute: self.minute, second: self.second)
                //              //起床時刻から現在時刻を引いて文字列で残り時間を返す。
                if wakeUpTime < nowTime {
                    wakeUpTime += timeConversion(hour: 24, minute: 0)
                }
                dispTime = timeConversion2(second: nowTime)
                
            }
        }
        
        if !userData.permission {
            Text("通知が許可されていません。このアプリを利用するには通知を許可して下さい。")
            Button("設定画面を開く"){
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }
        }
        
    }
}
