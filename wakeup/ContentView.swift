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
    
    var body: some View {
        
        VStack {
            if !wakeup[0].completion {
                Registration()
            } else {
                TopPage(userData: $userData)
                    .onAppear() {
                        setUserData()
                        Task {
                            var res = await requestAuthorization()
                            if !res {
                                print("通知を許可して下さい。")
                            }
                        }
                        
                    }
            }
            
            
        }
        .onAppear() {
            initUserData()
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
            
            userData.wakeUpTime = wakeup[0].wakeUpTime!
            userData.bedTime = wakeup[0].bedTime!
            userData.permission = wakeup[0].permission
            
            print("set")
    }
    
}


//#Preview {
//    ContentView()
//}
//
