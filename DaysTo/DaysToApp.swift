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
    @StateObject var daysToVM: DaysToViewModel = DaysToViewModel()
    @StateObject var authentification: AuthentificationViewModel = AuthentificationViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(daysToVM)
                .environmentObject(authentification)
        }
    }
}
