//
//  UserViewModels.swift
//  DeafHealth
//
//  Created by Kurnia Kharisma Agung Samiadjie on 23/08/24.
//

import Foundation

class UserDataViewModel: ObservableObject {
    @Published var currentUser: UserData? = nil
    private var datasource: LocalDataSource

    @MainActor
    init(datasource: LocalDataSource) {
        self.datasource = datasource
        if let newData = datasource.fetchUserData() {
            if newData.name != "" && newData.age != "" {
                currentUser = newData
            }
        }
    }
}
