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
    var foodAllergy: String?
    var drugAllergy: String?
    var conditionAllergy: String?

    init(name: String, age: String, gender: Gender, foodAllergy: String? = nil, drugAllergy: String? = nil, conditionAllergy: String? = nil) {
        self.name = name
        self.age = age
        self.gender = gender
        self.foodAllergy = foodAllergy
        self.drugAllergy = drugAllergy
        self.conditionAllergy = conditionAllergy
    }
}
