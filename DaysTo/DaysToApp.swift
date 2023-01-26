//
//  DaysToApp.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 22.01.2023.
//

import SwiftUI

@main
struct DaysToApp: App {
    
    @StateObject var eventsVM: EventsViewModel = EventsViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(eventsVM)
        }
    }
}
