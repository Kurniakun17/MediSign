//
//  Role.swift
//  DeafHealth
//
//  Created by Kurnia Kharisma Agung Samiadjie on 21/08/24.
//

import Foundation

enum Role: String, CaseIterable, Identifiable {
    case user = "User"
    case doctor = "Doctor"

    var id: String { rawValue }
}
