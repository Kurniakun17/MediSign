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
        self.modelContainer = try! ModelContainer(for: Complaint.self, SymptomsDetail.self, UserData.self, configurations: ModelConfiguration(isStoredInMemoryOnly: false))
        self.modelContext = modelContainer.mainContext
    }

    func removeData() {}

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

    func delete(userData: UserData) {
        do {
            modelContext.delete(userData)
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func saveUserData(name: String, age: String, gender: Gender, foodAllergy: String?, drugAllergy: String?, conditionAllergy: String?, profileImageData: Data?) {
        do {
            if let existingUserData = fetchUserData() {
                // Update existing user data
                existingUserData.name = name
                existingUserData.age = age
                existingUserData.gender = gender
                existingUserData.foodAllergy = foodAllergy
                existingUserData.drugAllergy = drugAllergy
                existingUserData.conditionAllergy = conditionAllergy
                existingUserData.profileImageData = profileImageData
            } else {
                // Create new user data
                let userData = UserData(name: name, age: age, gender: gender, foodAllergy: foodAllergy, drugAllergy: drugAllergy, conditionAllergy: conditionAllergy, profileImageData: profileImageData)
                modelContext.insert(userData)
            }

            try modelContext.save()
            print("User data saved successfully")

        } catch {
            print("Failed to save user data: \(error.localizedDescription)")
        }
    }

    func fetchUserData() -> UserData? {
        do {
            return try modelContext.fetch(FetchDescriptor<UserData>()).first
        } catch {
            fatalError("Failed to fetch user data: \(error.localizedDescription)")
        }
    }

    func fetchAllUserData() -> [UserData] {
        do {
            return try modelContext.fetch(FetchDescriptor<UserData>())
        } catch {
            fatalError("Failed to fetch user data: \(error.localizedDescription)")
        }
    }
}
