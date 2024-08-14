//
//  Coordinator:Coordinator.swift
//  DeafHealth
//
//  Created by Kurnia Kharisma Agung Samiadjie on 13/08/24.
//

import Foundation
import SwiftUI

enum Page {
//    case home
//    case complaint
//    case detailSymptoms
//    case communcation
//

    // MARK: Example Page

    case banana
    case lemon
    case watermelon
    case strawberry
    case pineapple
}

enum Sheet {
    case speechToText
}

enum FullScreenCover {
    case testCover
}

class Coordinator: ObservableObject {
    @Published var path = NavigationPath()
    @Published var sheet: Sheet?
    @Published var fullScreenCover: FullScreenCover?

    func push(page: Page) {
        self.path.append(page)
    }

    func present(sheet: Sheet) {
        self.sheet = sheet
    }

    func present(fullScreenCover: FullScreenCover) {
        self.fullScreenCover = fullScreenCover
    }

    func dismissSheet() {
        self.sheet = nil
    }

    func dismissFullScreenCover() {
        self.fullScreenCover = nil
    }

    func popToRoot() {
        self.path.removeLast(self.path.count)
    }

    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
            case .banana:
                Banana()
            case .lemon:
                Lemon()
            case .strawberry:
                Strawberry()
            case .watermelon:
                Watermelon()
            case .pineapple:
                Pineapple()
        }
    }
}
