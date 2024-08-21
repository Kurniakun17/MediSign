//
//  Message.swift
//  DeafHealth
//
//  Created by Kurnia Kharisma Agung Samiadjie on 16/08/24.
//

import Foundation

struct Message: Identifiable, Equatable {
    var id = UUID()
    var role: Role
    var body: String

    init(id: UUID = UUID(), role: Role, body: String) {
        self.id = id
        self.role = role
        self.body = body
    }
}
