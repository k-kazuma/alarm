//
//  Setting.swift
//  wakeup
//
//  Created by 熊谷知馬 on 2023/12/23.
//

import SwiftUI

struct Setting: View {
    @Binding var userData: UserData
    
    var body: some View {
        List {
            HStack{
                Text("起床時刻:\(userData.wakeUpTime == "" ? userData.wakeUpTime : timeConversion2(second: Int(userData.wakeUpTime)!))")
                Spacer()
                Text("変更")
            }
            HStack{
                Text("就寝時刻:\(userData.bedTime == "" ? userData.bedTime : timeConversion2(second: Int(userData.bedTime)!))")
                Spacer()
                Text("変更")
            }
            HStack{
                Text("アラーム音")
                Spacer()
                Text("変更")
            }
            
            
            
            
            
        }
    }
}
//
//#Preview {
//    Setting()
//}
