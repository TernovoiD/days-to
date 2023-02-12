//
//  NotificationCenter.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 11.02.2023.
//

import Foundation
import UserNotifications

class NotificationCenter {
    
    static let instance = NotificationCenter()
    
    func askPermissionToNotifications() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        let notificationCenter: UNUserNotificationCenter = UNUserNotificationCenter.current()
        notificationCenter.requestAuthorization(options: options) { success, error in
            if let error = error {
                print("Error while asking permission for notifications: \(error)")
            } else {
                print("Notification permission recieved (success)")
            }
        }
    }
}

