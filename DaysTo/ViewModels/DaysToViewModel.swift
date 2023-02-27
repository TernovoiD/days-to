//
//  DaysToViewModel.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 02.02.2023.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class DaysToViewModel: ObservableObject {
    
    // MARK: Authentification and User information
    @AppStorage("isSignedIn") var isSignedIn: Bool = false
    @AppStorage("userID") var userID: String = ""
    @Published private(set) var userInfo: UserModel?
    
    // MARK: Navigation (transitions)
    @Published var showAddEventView: Bool = false
    @Published var showSettingsView: Bool = false
    @Published var showEditEventView: Bool = false
    @Published var showMyAccount: Bool = false
    @Published var showCreditsView: Bool = false
    @Published var selectedEvent: EventModel?
    @Published var eventToEdit: EventModel?
    
    // MARK: Alerts
    @Published var alertMessage: String = ""
    @Published var alert: Bool = false
    
    // MARK: Data
    @Published private(set) var events: [EventModel] = []
    
    let firebaseAuth = Auth.auth()
    let database = Firestore.firestore()
        
    
    init() {
        getUserInfo()
    }
    
    // MARK: Authentification
    
    func signUp(userName: String, userEmail: String, userDateOfBirth: Date, userPassword: String) {
        firebaseAuth.createUser(withEmail: userEmail, password: userPassword) { result, error in
            if let error = error {
                print("Error while sign in: \(error.localizedDescription)")
                self.showAlert(message: error.localizedDescription)
            } else {
                self.signIn(userEmail: userEmail, userPassword: userPassword)
                self.getUserInfo()
                self.addUser(name: userName, email: userEmail, dateOfBirth: userDateOfBirth)
            }
        }
    }
    
    func signIn(userEmail: String, userPassword: String) {
        firebaseAuth.signIn(withEmail: userEmail, password: userPassword) { result, error in
            if let error = error {
                print("Error while sign in: \(error.localizedDescription)")
                self.showAlert(message: error.localizedDescription)
                return
            } else {
                self.isSignedIn = true
                self.getUserInfo()
            }
        }
    }
    
    func signOut() {
        do {
          try firebaseAuth.signOut()
            isSignedIn = false
        } catch let error {
            print("Error signing out: \(error.localizedDescription)")
            self.showAlert(message: error.localizedDescription)
        }
        self.userInfo = nil
    }
    
    func sendEmailVerification() {
        firebaseAuth.currentUser?.sendEmailVerification { error in
            if let error = error {
                print("Error while sending email verification: \(error.localizedDescription)")
                self.showAlert(message: error.localizedDescription)
            }
        }
    }
    
    func updatePassword(password: String) {
        firebaseAuth.currentUser?.updatePassword(to: password) { error in
            if let error = error {
                print("Error while updating password: \(error.localizedDescription)")
                self.showAlert(message: error.localizedDescription)
            }
        }
    }
    
    func resetPassword(email: String) {
        firebaseAuth.sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("Error while sending email reset: \(error.localizedDescription)")
                self.showAlert(message: error.localizedDescription)
            }
        }
    }
    
    func getUserInfo() {
        firebaseAuth.addStateDidChangeListener { auth, user in
            if let user = user {
                self.userID = user.uid
                self.fetchUserInfo()
                self.fetchUserEvents()
            } else {
                self.isSignedIn = false
                self.userID = ""
            }
        }
    }
    
//    func reauthentificateUser() {
//        let user = firebaseAuth.currentUser
//        var credential = firebaseAuth.emai
//
//        // Prompt the user to re-provide their sign-in credentials
//
//        user?.reauthenticate(with: credential) { error in
//          if let error = error {
//            // An error happened.
//          } else {
//            // User re-authenticated.
//          }
//        }
//    }
    
    func deleteUser() {
        let user = firebaseAuth.currentUser

        user?.delete { error in
          if let error = error {
              print("Error while deleting user account: \(error.localizedDescription)")
              self.showAlert(message: error.localizedDescription)
          }
        }
    }
    
    private func showAlert(message: String) {
        alertMessage = message
        alert = true
    }
    
    // MARK: Events filter
    
    @Published var textToSearch: String = ""
    @Published var showFavoriteOnly: Bool = false
    @Published var sevenDays: Bool = false

    func eventsfilterdBySearch() -> [EventModel] {
        var eventsToFilter = events

        if showFavoriteOnly {
            eventsToFilter = eventsToFilter.filter({ $0.isFavorite })
        }
        if sevenDays {
            eventsToFilter = eventsToFilter.filter({ $0.daysTo <= 7 })
        }
        if !textToSearch.isEmpty {
            let text: String = textToSearch.lowercased()
            eventsToFilter = eventsToFilter.filter({ $0.name.lowercased().contains(text)})
        }
        return eventsToFilter
    }
    
    func fetchUserInfo() {
        database.collection("users").document(userID).addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error while loading user info: \(String(describing: error))")
                return
            }
            do {
                try self.userInfo = document.data(as: UserModel.self)
            } catch {
                print("Error while decoding user info: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchUserEvents() {
        database.collection("users").document(userID).collection("events").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error while loading Evnts: \(String(describing: error))")
                return
            }
            let allEvents = documents.compactMap { document -> EventModel? in
                do {
                    return try document.data(as: EventModel.self)
                } catch {
                    print("Error while decoding Event: \(error.localizedDescription)")
                    return nil
                }
            }
            self.events = allEvents.sorted(by: { $0.daysTo < $1.daysTo })
        }
    }
    
    func addEvent(name: String, description: String, date: Date, isFavorite: Bool, isRepeated: Bool) {
        let newEvent = EventModel(date: date, name: name, isRepeated: isRepeated, isFavorite: isFavorite, description: description)
        do {
            try database.collection("users").document(userID).collection("events").document(newEvent.id).setData(from: newEvent)
        } catch {
            print("Error while add new Event:\(error.localizedDescription)")
        }
    }
    
    func toggleEventFavoriteStatus(event: EventModel) {
        let eventRef = database.collection("users").document(userID).collection("events").document(event.id)
        let newStatus = !event.isFavorite
        
        eventRef.updateData([
            "isFavorite" : newStatus
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    func editEvent(eventID: String, eventName: String, eventDescription: String, eventDate: Date, isFavorite: Bool, isRepeated: Bool) {
        let eventRef = database.collection("users").document(userID).collection("events").document(eventID)
        
        eventRef.updateData([
            "name" : eventName,
            "description" : eventDescription,
            "date" : eventDate,
            "isRepeated" : isRepeated,
            "isFavorite" : isFavorite
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    func deleteEvent(event: EventModel) {
        database.collection("users").document(userID).collection("events").document(event.id).delete()
    }
    
    func addUser(name: String, email: String, dateOfBirth: Date) {
        let user = UserModel(id: userID, name: name, email: email, dateOfBirth: dateOfBirth)
        do {
            try database.collection("users").document(userID).setData(from: user)
        } catch {
            print("Error while add new Event:\(error.localizedDescription)")
        }
    }
    
    // MARK: DateCalculations Controller
    private let dateCalculations = DateCalculationsModel()
    
    func daysInCurrentMonth() -> Int {
        return dateCalculations.getDaysInCurrentMonth()
    }
    func daysLeftInCurrentMonth() -> Int {
        return dateCalculations.getDaysLeftCurrentMonth()
    }
    func daysInCurrentYear() -> Int {
        return dateCalculations.getDaysInCurrentYear()
    }
    func daysLeftInCurrentYear() -> Int {
        return dateCalculations.getDaysLeftCurrentYear()
    }
    
    func startOfNextMonthDate() -> Date {
        return dateCalculations.getStartOfNextMonthDate()
    }
    
    func startOfNextYearDate() -> Date {
        return dateCalculations.getStartOnNextYearDate()
    }

}
