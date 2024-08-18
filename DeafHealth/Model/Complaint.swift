//
//  Complaint.swift
//  DeafHealth
//
//  Created by Kurnia Kharisma Agung Samiadjie on 13/08/24.
//

import Foundation
import SwiftData

@Model
class Complaint {
    var user: UserData
    var symptoms: [SymptomsDetail]
    var summary: String
    var answers: [String]
    var date: Date

    init(user: UserData, symptoms: [SymptomsDetail], summary: String, answers: [String], date: Date = Date()) {
        self.user = user
        self.symptoms = symptoms
        self.summary = summary
        self.answers = answers
        self.date = date
    }
}
