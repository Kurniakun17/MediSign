//
//  LocalData.swift
//  DeafHealth
//
//  Created by Kurnia Kharisma Agung Samiadjie on 13/08/24.
//

import Foundation
import SwiftData

class LocalDataSource {
    let modelContainer: ModelContainer
    let modelContext: ModelContext

    @MainActor
    static let shared = LocalDataSource()

    @MainActor
    init() {
        self.modelContainer = try! ModelContainer(for: Complaint.self, SymptomsDetail.self, UserData.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        self.modelContext = modelContainer.mainContext
    }

    func fetchSymptomsDetail() -> [SymptomsDetail] {
        do {
            return try modelContext.fetch(FetchDescriptor<SymptomsDetail>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func fetchComplaint() -> [Complaint] {
        do {
            return try modelContext.fetch(FetchDescriptor<Complaint>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func add(symptomsDetail: SymptomsDetail) {
        do {
            modelContext.insert(symptomsDetail)
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func add(complaint: Complaint) {
        do {
            modelContext.insert(complaint)
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func delete(complaint: Complaint) {
        do {
            modelContext.delete(complaint)
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

