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
    @Published private(set) var answers: [String] = ["_____", "_____", "_____", "_____", "_____", "_____", "_____", "_____"]
    @Published private(set) var summary: [String] = ["Saya merasakan ", "Saya merasakan gejala ini sejak ", " yang lalu", "Rasa sakitnya ", " dari 10", "Gejalanya semakin parah ketika saya ", "Gejalanya semakin membaik ketika saya ", "Pernah konsultasi ke dokter lain dan diberi obat yaitu "]

    private let dataSource: LocalDataSource

    init(datasource: LocalDataSource) {
        self.dataSource = datasource
        updateComplaintSummary(for: 0)
    }

    func updateAnswer(for questionIndex: Int, with answer: String) {
        guard questionIndex < answers.count else { return }
        answers[questionIndex] = answer
        updateComplaintSummary(for: questionIndex + 1)
    }

    func getSummary(for questionIndex: Int) -> String {
        return summary[questionIndex]
    }

//    func getSummary(for questionIndex: Int) -> String {
//        return buildComplaintSummary(upTo: questionIndex)
//    }

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
}
