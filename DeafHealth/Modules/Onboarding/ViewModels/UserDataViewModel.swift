//
//  UserViewModels.swift
//  DeafHealth
//
//  Created by Kurnia Kharisma Agung Samiadjie on 23/08/24.
//

import Foundation

class UserDataViewModel: ObservableObject {
    @Published var currentUser: UserData? = nil
    @Published var users: [UserData]
    private var datasource: LocalDataSource

    @MainActor
    init(datasource: LocalDataSource) {
        self.datasource = datasource
        if let newData = datasource.fetchUserData() {
            if newData.name != "" && newData.age != "" {
                currentUser = newData
            }
        }

        users = datasource.fetchAllUserData()
    }

    func deleteAllData() {
        for user in users{
            datasource.delete(userData: user)
        }
        currentUser = nil
    }
}
