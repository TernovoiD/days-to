//
//  DaysToWidgetBundle.swift
//  DaysToWidget
//
//  Created by Danylo Ternovoi on 27.02.2023.
//

import WidgetKit
import SwiftUI
import Firebase

@main
struct DaysToWidgetBundle: WidgetBundle {
    
    init() {
        FirebaseApp.configure()
        authUserAccessGroup()
    }
    
    var body: some Widget {
        DaysToWidget()
    }
    
    func authUserAccessGroup() {
        do {
            try Auth.auth().useUserAccessGroup("MWQ8P93RWJ.com.danyloternovoi.DaysTo")
        } catch let error as NSError {
            print("Error changing user access group: %@", error)
        }
    }
}
