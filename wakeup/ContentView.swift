//
//  ContentView.swift
//  wakeup
//
//  Created by 熊谷知馬 on 2023/11/13.
//

import SwiftUI
import CoreData


struct UserData {
    var wakeUpTime: String
    var bedTime: String
    var permission: Bool
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) var wakeup: FetchedResults<Item>
    
    @State private var userData = UserData(wakeUpTime: "", bedTime: "", permission: false)
    
    @Environment(\.scenePhase) private var scenePhase
    
    
    var body: some View {
        
        VStack {
            if !wakeup[0].completion {
                Registration()
            } else {
                TopPage(userData: $userData)
//                    .onAppear() {
//                        setUserData()
//                        //                        Task {
//                        //                            var res = await requestAuthorization()
//                        //                            if !res {
//                        //                                print("通知を許可して下さい。")
//                        //                            }
//                        //                        }
//                        
//                    }
            }
            
            
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                print("復帰")
                setUserData()
            }
        }
        .onAppear() {
            if wakeup[0].wakeUpTime != nil && wakeup[0].bedTime != nil {
                setUserData()
            } else {
                initUserData()
            }
            
            
        }
        
        //       データーベースを初期化する処理。
        Button("初期化（テスト環境用です。）") {
            
            for i in wakeup {
                viewContext.delete(i)
            }
            
            let wakeUpTime = Item(context: viewContext)
            wakeUpTime.wakeUpTime = nil
            wakeUpTime.bedTime = nil
            wakeUpTime.completion = false
            
            do {
                try viewContext.save()
            } catch {
                fatalError("失敗")
            }
        }
        .padding()
        
        
    }
    
    func initUserData() {
        //データベースが空の場合初期値を設定
        guard wakeup.count == 0  else {
            return
        }
        
        let wakeUpTime = Item(context: viewContext)
        wakeUpTime.wakeUpTime = nil
        wakeUpTime.bedTime = nil
        wakeUpTime.completion = false
        
        do {
            try viewContext.save()
        } catch {
            fatalError("失敗")
        }
        
    }
    
    func setUserData() {
        guard wakeup[0].wakeUpTime != nil && wakeup[0].bedTime != nil  else{
            return
        }
        Task {
            let res = await requestAuthorization()
            print("Userdata:\(res)")
            print(userData)
            userData.wakeUpTime = wakeup[0].wakeUpTime!
            userData.bedTime = wakeup[0].bedTime!
            userData.permission = res
        }
        
        
        
        
    }
    
}

struct testView: View {
    
    @State var dispTime = ""
    @State var waitingTime = ""
    @State var nowTime = Date()
    let dateFormatterTime = DateFormatter()
    let calender = Calendar.current
    let date = Date()
    @State var hour:Int = 0
    @State var minute:Int = 0
    @State var second:Int = 0
    @State var time = timeConversion(hour: 9, minute: 0)
    
    init() {
        dateFormatterTime.dateStyle = .none
        dateFormatterTime.timeStyle = .short
    }
    
    
    var body: some View {
        ZStack{
            Color.gray
            VStack{
                Spacer()
                VStack{
                    Text(dispTime.isEmpty ? "\(dateFormatterTime.string(from: nowTime))" : dispTime)
                    Text("起床時間まであと\(waitingTime)")
                    Text("就寝時間まであと")
                }
                Spacer()
                HStack{
                    Button("設定") {
                        
                    }
                    .fontWeight(.semibold)
                    .frame(width: 160, height: 48)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(24)
                }
                .padding()
            }
        }
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        .onAppear {
            //毎秒処理をする
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                //現在の日時を取得し時、分、秒それぞれ格納する
                self.nowTime = Date()
                self.hour = calender.component(.hour, from: nowTime)
                self.minute = calender.component(.minute, from: nowTime)
                self.second = calender.component(.second, from: nowTime)
                
                //現在時刻を秒数に変換
                let nowTime = timeConversion(hour: self.hour, minute: self.minute, second: self.second)
//              //起床時刻から現在時刻を引いて文字列で残り時間を返す。
                if time < nowTime {
                    time += timeConversion(hour: 24, minute: 0)
                }
                dispTime = timeConversion2(second: nowTime)
                waitingTime = timeConversion2(second: time - nowTime)
            }
        }
    }
}

//時間を秒数に変換
func timeConversion(hour:Int, minute:Int, second:Int = 0) -> Int {
    //起床時刻が翌日であれば２４時間加算する処理を追加が必要。
    
    
    return hour*60*60 + minute*60 + second
}

//秒数を時分へ変換し文字列を返す
func timeConversion2(second:Int) -> String {
    let hour = second / 3600
    let minute = second / 60 % 60
    let second = second % 60
    return "\(hour)時\(minute)分\(second)秒"
}


//#Preview {
//    testView()
//    
//}
