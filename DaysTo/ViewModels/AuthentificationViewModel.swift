//
//  AuthentificationViewModel.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 12.02.2023.
//

import SwiftUI
import FirebaseAuth

class AuthentificationViewModel: ObservableObject {
    @AppStorage("isSignedIn") var isSignedIn: Bool = false
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var alertMessage: String = ""
    @Published var alert: Bool = false
    let firebaseAuth = Auth.auth()
    
    private func showAlert(message: String) {
        alertMessage = message
        alert = true
    }
    
    func signIn() {
        if email.isEmpty || password.isEmpty {
            showAlert(message: "Neither email nor password can be empty.")
            return
        } else {
            firebaseAuth.signIn(withEmail: email, password: password) { result, error in
                if let error = error {
                    print("Error while sign in: \(error.localizedDescription)")
                    self.showAlert(message: error.localizedDescription)
                } else {
                    self.isSignedIn = true
                }
            }
        }
    }
    
    func signUp() {
        if email.isEmpty || password.isEmpty {
            showAlert(message: "Neither email nor password can be empty.")
            return
        } else {
            firebaseAuth.createUser(withEmail: email, password: password) { result, error in
                if let error = error {
                    print("Error while sign in: \(error.localizedDescription)")
                    self.showAlert(message: error.localizedDescription)
                } else {
                    self.signIn()
                }
            }
        }
    }
    
    func signOut() {
        do {
          try firebaseAuth.signOut()
            isSignedIn = false 
        } catch let error {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
    
    func checkStatus() {
        firebaseAuth.addStateDidChangeListener { auth, user in
//            if let user = user {
//                let uid = user.uid
//                let email = user.email
//                let photoURL = user.photoURL
//                var multiFactorString = "MultiFactor: "
//                for info in user.multiFactor.enrolledFactors {
//                    multiFactorString += info.displayName ?? "[DispayName]"
//                    multiFactorString += " "
//                }
//            }
        }
    }
        
    
}




    
