//
//  UserProfile.swift
//  DeafHealth
//
//  Created by Kurnia Kharisma Agung Samiadjie on 13/08/24.
//

import Foundation
import SwiftData

@Model
class UserData {
    var name: String
    var age: String
    var gender: Gender

    init(name: String, age: String, gender: Gender) {
        self.name = name
        self.age = age
        self.gender = gender
    }
}
