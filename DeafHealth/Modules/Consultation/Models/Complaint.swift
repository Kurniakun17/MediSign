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
    var id: UUID
    var name: String = ""
    var user: UserData
    var symptoms: [SymptomsDetail]
    var summary: String
    var answers: [String]
    var date: Date

    init(id: UUID = UUID(), user: UserData, name: String = "", symptoms: [SymptomsDetail], summary: String, answers: [String], date: Date = Date()) {
        self.id = id
        self.name = name
        self.user = user
        self.symptoms = symptoms
        self.summary = summary
        self.answers = answers
        self.date = date
    }
}
