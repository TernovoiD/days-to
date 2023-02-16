//
//  UserModel.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 14.02.2023.
//

import Foundation

struct UserModel: Identifiable, Codable {
    let id: String
    let name: String
    let email: String
    let dateOfBirth: Date
}
