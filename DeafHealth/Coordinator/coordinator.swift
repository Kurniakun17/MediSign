//
//  Coordinator:Coordinator.swift
//  DeafHealth
//
//  Created by Kurnia Kharisma Agung Samiadjie on 13/08/24.
//

import Foundation
import SwiftUI

enum Page: String, Identifiable {
    // MARK: Add Your Page Here

    case mainComplaint
    case selectBodyPart
    case symptomStartTime
    case symptomSeverity
    case symptomWorseningFactors
    case symptomImprovementFactors
    case previousConsultation
    case summary
    case consultationMenuView
    // MARK: Example Data

    case banana
    case lemon
    case watermelon
    case strawberry
    case pineapple
    case communication

    var id: String {
        self.rawValue
    }
}

enum Sheet: Identifiable {
    // MARK: Add Your Sheet Here

    // MARK: Example Data

    case testSheet
    case selectBodyPart
    case symptomStartTime
    case symptomSeverity
    case symptomWorseningFactors
    case symptomImprovementFactors
    case previousConsultation

    var id: String {
        self.id
    }
}

enum FullScreenCover: String, Identifiable {
    // MARK: Add Your Full Screen Cover Here

    // MARK: Example Data

    case testFullScreenCover

    var id: String {
        self.rawValue
    }
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

    func pop() {
        self.path.removeLast(1)
    }

    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
        case .mainComplaint:
            ComplaintView()
        case .selectBodyPart:
            SelectBodyPartView()
        case .symptomStartTime:
            SymptomStartTimeView()
        case .symptomSeverity:
            SymptomSeverityView()
        case .symptomWorseningFactors:
            SymptomWorseningFactorsView()
        case .symptomImprovementFactors:
            SymptomImprovementFactorsView()
        case .previousConsultation:
            PreviousConsultationView()
        case .summary:
            SummaryView()
        case .consultationMenuView: // Add this case
            ConsultationMenuView()
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
        case .communication:
            CommunicationPage()
        }
    }

    @ViewBuilder
    func build(sheet: Sheet) -> some View {
        switch sheet {
        case .testSheet:
            NavigationStack {
                TestSheet()
            }
        case .symptomStartTime:
            NavigationStack {
                SymptomStartTimeView()
            }
        case .selectBodyPart:
            NavigationStack {
                SelectBodyPartView()
            }
        case .symptomSeverity:
            NavigationStack {
                SymptomSeverityView()
            }
        case .symptomWorseningFactors:
            NavigationStack {
                SymptomWorseningFactorsView()
            }
        case .symptomImprovementFactors:
            NavigationStack {
                SymptomImprovementFactorsView()
            }
        case .previousConsultation:
            NavigationStack {
                PreviousConsultationView()
            }
        }
    }

    @ViewBuilder
    func build(fullScreenCover: FullScreenCover) -> some View {
        switch fullScreenCover {
        case .testFullScreenCover:
            NavigationStack {
                TestFullScreenCover()
            }
        }
    }
}
