//
//  notification.swift
//  wakeup
//
//  Created by 熊谷知馬 on 2023/11/26.
//

import SwiftUI
import UserNotifications

public func requestAuthorization() async -> Bool {
    do {
        let reqestResult = try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge])
        return reqestResult
    } catch {
        print(error)
        return false
        
    }
}
