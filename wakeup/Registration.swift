//
//  Registration.swift
//  wakeup
//
//  Created by 熊谷知馬 on 2023/11/19.
//

import SwiftUI
import CoreData

struct Registration: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) var wakeup: FetchedResults<Item>
    @State var wakeUpTime: Date = Date()
    @State var bedTime: Date = Date()
    
    let bounds = UIScreen.main.bounds
    
    var body: some View {
        
        if wakeup[0].wakeUpTime == nil {
            Text("起床時刻を選択")
            DatePicker("起床時間", selection:$wakeUpTime, displayedComponents: .hourAndMinute)
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
            
            Button("追加") {
                do {
                    try newWakeUpTime(time: wakeUpTime)
                } catch {
                    fatalError("error")
                }
                
                
            }
        }
        
        if wakeup[0].wakeUpTime != nil  && wakeup[0].bedTime == nil {
            Text("就寝時刻を選択")
            DatePicker("就寝時間", selection:$wakeUpTime, displayedComponents: .hourAndMinute)
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
            
            Button("追加") {
                do {
                    try newBedTime(time: bedTime)
                } catch {
                    fatalError("error")
                }
            }
        }
        
        if wakeup[0].wakeUpTime != nil  && wakeup[0].bedTime != nil {
            Text("起床時刻：\(wakeup[0].wakeUpTime!)")
            Text("就寝時刻：\(wakeup[0].bedTime!)")
            Button("通知を許可してアラームをセット") {
                wakeup[0].completion = true
                do {
                    Task {
                        permission = await requestAuthorization()
                    }
                    try viewContext.save()
                } catch {
                    fatalError("失敗")
                }
                
            }
        }
    }
    
    func newWakeUpTime (time: Date) throws {
        let newTime = formatter(time: time)
        wakeup[0].wakeUpTime = newTime
        do {
            try viewContext.save()
        } catch {
            fatalError("失敗")
        }
        
    }
    
    func newBedTime (time: Date) throws {
        let newTime = formatter(time: time)
        wakeup[0].bedTime = newTime
        do {
            try viewContext.save()
        } catch {
            fatalError("失敗")
        }
        
    }
    
    func formatter(time: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: time)
    }
    
}
//
//#Preview {
//    Registration()
//}
