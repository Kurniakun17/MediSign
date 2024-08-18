//
//  File.swift
//  DeafHealth
//
//  Created by Alifiyah Ariandri on 18/08/24.
//

import Foundation

@Observable
class SymptomStartTimeViewModel {
    var options: [Option] =
        [
            Option(title: "<24 jam yang lalu"),
            Option(title: "1 hari yang lalu"),
            Option(title: "2-3 hari yang lalu"),
            Option(title: "1 minggu yang lalu"),
            Option(title: "Lebih dari 1 minggu yang lalu"),
        ]

    func selectedOption() {
        for index in options.indices {
            options[index].isSelected = false
        }
    }

    func selectedOption(optionId id: UUID) {
        for index in options.indices {
            options[index].isSelected = (options[index].id == id)
        }
    }
}

struct Option: Identifiable {
    let id = UUID()
    var title: String
    var isSelected: Bool = false
}
