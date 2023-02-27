//
//  DaysToApp.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 22.01.2023.
//

import SwiftUI
import Firebase

@main
struct DaysToApp: App {
    @StateObject var daysToVM = DaysToViewModel()
    init() {
        FirebaseApp.configure()
        authUserAccessGroup()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(daysToVM)
        }
    }
    
    func authUserAccessGroup() {
        do {
            try Auth.auth().useUserAccessGroup("MWQ8P93RWJ.com.danyloternovoi.DaysTo")
        } catch let error as NSError {
            print("Error changing user access group: %@", error)
        }
    }
}
