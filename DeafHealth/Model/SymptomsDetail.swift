//
//  SymptomsDetail.swift
//  DeafHealth
//
//  Created by Kurnia Kharisma Agung Samiadjie on 13/08/24.
//

import Foundation
import SwiftData

@Model
class SymptomsDetail {
    var type: SymptomsType
    var position: [String] = []
    var dateOccurred: Date
    var durationInDays: Int
    var severity: Int
    var feelWorse: [String] = []
    var feelBetter: [String] = []
    var additionalNotes: String?
    
    init(type: SymptomsType, position: [String], dateOccurred: Date, durationInDays: Int, severity: Int, feelWorse: [String], feelBetter: [String], additionalNotes: String? = nil) {
        self.type = type
        self.position = position
        self.dateOccurred = dateOccurred
        self.durationInDays = durationInDays
        self.severity = severity
        self.feelWorse = feelWorse
        self.feelBetter = feelBetter
        self.additionalNotes = additionalNotes
    }
}
