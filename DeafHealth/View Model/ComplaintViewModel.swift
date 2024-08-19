//
//  ComplaintViewModel.swift
//  DeafHealth
//
//  Created by Kurnia Kharisma Agung Samiadjie on 13/08/24.
//

import Foundation
import SwiftData

class ComplaintViewModel: ObservableObject {
    @Published private(set) var complaintSummary: String = "Halo Dokter. Saya merasakan _____." // Initial placeholder text
    @Published private(set) var answers: [String] = ["", "", "", "", "", "", "", ""]

    var startTimeOptions: [Option] =
        [
            Option(title: "<24 jam yang lalu"),
            Option(title: "1 hari yang lalu"),
            Option(title: "2-3 hari yang lalu"),
            Option(title: "1 minggu yang lalu"),
            Option(title: "Lebih dari 1 minggu yang lalu"),
        ]

    var worseningOptions: [Option] =
        [
            Option(title: "Aktivitas fisik"),
            Option(title: "Stress"),
            Option(title: "Makanan atau minuman tertentu"),
            Option(title: "Di suhu tertentu"),
            Option(title: "Di waktu tertentu"),
            Option(title: "Tidak tahu"),
            Option(title: "Tidak ada"),
        ]

    var improvementOptions: [Option] =
        [
            Option(title: "Istirahat"),
            Option(title: "Minum obat"),
            Option(title: "Kompres panas/dingin"),
            Option(title: "Konsumsi makanan/minuman tertentu"),
            Option(title: "Tidak tahu"),
            Option(title: "Tidak ada"),
        ]

    private let dataSource: LocalDataSource

    init(datasource: LocalDataSource) {
        self.dataSource = datasource
        updateComplaintSummary(for: 0) // Initialize with the first placeholder
    }

    func updateAnswer(for questionIndex: Int, with answer: String) {
        guard questionIndex < answers.count else { return }
        answers[questionIndex] = answer
        updateComplaintSummary(for: questionIndex + 1) // Update for the next question
    }

    func getSummary(for questionIndex: Int) -> String {
        return buildComplaintSummary(upTo: questionIndex)
    }

    private func buildComplaintSummary(upTo currentQuestionIndex: Int) -> String {
        var summaryParts: [String] = []

        if currentQuestionIndex >= 0 {
            summaryParts.append("Halo Dokter. Saya merasakan \(answers[0].isEmpty ? "_____" : answers[0]).")
        }

        if currentQuestionIndex >= 1 {
            summaryParts.append(" di \(answers[1].isEmpty ? "_____" : answers[1]).")
        }

        if currentQuestionIndex >= 2 {
            summaryParts.append(" Saya merasakan gejala ini sejak \(answers[2].isEmpty ? "_____" : answers[2]).")
        }

        if currentQuestionIndex >= 3 {
            summaryParts.append(" Rasa sakitnya \(answers[3].isEmpty ? "_____" : answers[3]) dari 10.")
        }

        if currentQuestionIndex >= 4 {
            summaryParts.append(" Gejalanya semakin parah ketika saya \(answers[4].isEmpty ? "_____" : answers[4]).")
        }

        if currentQuestionIndex >= 5 {
            summaryParts.append(" Gejalanya semakin membaik ketika saya \(answers[5].isEmpty ? "_____" : answers[5]).")
        }

        if currentQuestionIndex >= 6 {
            summaryParts.append("Terdapat keluhan lain berupa \(answers[6].isEmpty ? "_____" : answers[6]).")
        }

        if currentQuestionIndex >= 7 {
            summaryParts.append("\(answers[7].isEmpty ? "_____" : answers[7]) pernah konsultasi ke dokter.")
        }

        // Return the summary up to the current question, plus a placeholder for the next unanswered part.
        return summaryParts.joined(separator: " ")
    }

    private func updateComplaintSummary(for currentQuestionIndex: Int) {
        DispatchQueue.main.async { [weak self] in
            self?.complaintSummary = self?.buildComplaintSummary(upTo: currentQuestionIndex) ?? ""
        }
    }

    func saveComplaint() {
        let userData = UserData(name: "John Doe", age: "30", gender: .male) // Example user data
        let symptoms = [SymptomsDetail]() // Example symptoms

        let complaint = Complaint(
            user: userData,
            symptoms: symptoms,
            summary: complaintSummary,
            answers: answers
        )
        dataSource.add(complaint: complaint)
    }

    func selectedOption(type: String) {
        if type == "time" {
            for index in startTimeOptions.indices {
                startTimeOptions[index].isSelected = false
            }
        }

        if type == "worsening" {
            for index in worseningOptions.indices {
                worseningOptions[index].isSelected = false
            }
        }

        if type == "improvement" {
            for index in improvementOptions.indices {
                improvementOptions[index].isSelected = false
            }
        }
    }

    func selectedOption(type: String, optionId id: UUID) {
        if type == "time" {
            for index in startTimeOptions.indices {
                startTimeOptions[index].isSelected = (startTimeOptions[index].id == id)
            }
        }

        if type == "worsening" {
            for index in worseningOptions.indices {
                worseningOptions[index].isSelected = (worseningOptions[index].id == id)
            }
        }

        if type == "improvement" {
            for index in improvementOptions.indices {
                improvementOptions[index].isSelected = (improvementOptions[index].id == id)
            }
        }
    }
}

struct Option: Identifiable {
    let id = UUID()
    var title: String
    var isSelected: Bool = false
}
