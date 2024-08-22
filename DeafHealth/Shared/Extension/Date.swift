//
//  Date.swift
//  DeafHealth
//
//  Created by Kurnia Kharisma Agung Samiadjie on 23/08/24.
//

import Foundation

extension Date {
    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "id_ID") // Indonesian locale
        formatter.dateFormat = "EEEE, dd MMMM yyyy" // "Selasa, 13 Agustus 2024" format
        return formatter.string(from: self)
    }
}
