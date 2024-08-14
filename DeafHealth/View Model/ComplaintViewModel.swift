//
//  ComplaintViewModel.swift
//  DeafHealth
//
//  Created by Kurnia Kharisma Agung Samiadjie on 13/08/24.
//

import Foundation

class ComplaintViewModel: ObservableObject {
    @Published var Complaints: [Complaint] = []

    private let dataSource: LocalDataSource

    init(datasource: LocalDataSource) {
        self.dataSource = datasource
        self.Complaints = datasource.fetchComplaint()
    }

    func add(complaint: Complaint) {
        dataSource.addComplaint(complaint: complaint)
    }

    func delete(complaint: Complaint) {
        dataSource.deleteComplaint(complaint: complaint)
    }
}
