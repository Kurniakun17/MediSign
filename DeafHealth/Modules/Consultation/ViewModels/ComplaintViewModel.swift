//
//  ComplaintViewModel.swift
//  DeafHealth
//
//  Created by Kurnia Kharisma Agung Samiadjie on 13/08/24.
//

import Foundation
import SwiftData

class ComplaintViewModel: ObservableObject {
    @Published var complaints: [Complaint] = []
    @Published var currentComplaint: Complaint
    @Published var isUpdating = false
    @Published private(set) var complaintSummary: String = "Halo Dokter. Saya merasakan _____." // Initial placeholder text
    @Published private(set) var answers: [String] = ["_____", "_____", "_____", "_____", "_____", "_____", "_____"]
    @Published private(set) var summary: [String] = ["Saya merasakan ", "Saya merasakan gejala ini sejak ", " yang lalu", "Rasa sakitnya ", " dari 10", "Gejalanya semakin parah ketika saya ", "Gejalanya semakin membaik ketika saya ", "Pernah konsultasi ke dokter lain dan diberi obat yaitu "]

    private let dataSource: LocalDataSource

    init(datasource: LocalDataSource) {
        dataSource = datasource
        currentComplaint = Complaint(user: dataSource.fetchUserData()!, symptoms: [SymptomsDetail](), summary: "Halo Dokter. Saya merasakan _____.", answers: ["_____", "_____", "_____", "_____", "_____", "_____", "_____"])
        updateComplaintSummary(for: 0)
        complaints = datasource.fetchComplaint()
    }

    func updateAnswer(for questionIndex: Int, with answer: String) {
        guard questionIndex < answers.count else { return }
        currentComplaint.answers[questionIndex] = answer
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
            summaryParts.append("Halo Dokter. Saya merasakan \(currentComplaint.answers[0].isEmpty ? "_____" : currentComplaint.answers[0]).")
        }

        if currentQuestionIndex >= 1 {
            summaryParts.append(" di \(currentComplaint.answers[1].isEmpty ? "_____" : currentComplaint.answers[1]).")
        }

        if currentQuestionIndex >= 2 {
            summaryParts.append(" Saya merasakan gejala ini sejak \(currentComplaint.answers[2].isEmpty ? "_____" : currentComplaint.answers[2]).")
        }

        if currentQuestionIndex >= 3 {
            summaryParts.append(" Rasa sakitnya \(currentComplaint.answers[3].isEmpty ? "_____" : currentComplaint.answers[3]) dari 10.")
        }

        if currentQuestionIndex >= 4 {
            summaryParts.append(" Gejalanya semakin parah ketika saya \(currentComplaint.answers[4].isEmpty ? "_____" : currentComplaint.answers[4]).")
        }

        if currentQuestionIndex >= 5 {
            summaryParts.append(" Gejalanya semakin membaik ketika saya \(currentComplaint.answers[5].isEmpty ? "_____" : currentComplaint.answers[5]).")
        }

        if currentQuestionIndex >= 6 {
            summaryParts.append("Terdapat keluhan lain berupa \(currentComplaint.answers[6].isEmpty ? "_____" : currentComplaint.answers[6]).")
        }

//        if currentQuestionIndex >= 7 {
//            summaryParts.append("\(answers[7].isEmpty ? "_____" : answers[7]) pernah konsultasi ke dokter.")
//        }

        // Return the summary up to the current question, plus a placeholder for the next unanswered part.
        return summaryParts.joined(separator: " ")
    }

    private func updateComplaintSummary(for currentQuestionIndex: Int) {
        DispatchQueue.main.async { [weak self] in
            self?.currentComplaint.summary = self?.buildComplaintSummary(upTo: currentQuestionIndex) ?? ""
        }
    }

    func saveComplaint(name: String) {
        currentComplaint.name = name

        if !isUpdating {
            dataSource.add(complaint: currentComplaint)
            complaints.append(currentComplaint)
        }

        // TODO: Reset answer to 0
        generateNewComplaint()
    }

    func resetAnswers() {
        complaintSummary = "Halo Dokter. Saya merasakan _____." // Initial placeholder text
        answers = ["_____", "_____", "_____", "_____", "_____", "_____", "_____"]
        summary = ["Saya merasakan ", "Saya merasakan gejala ini sejak ", " yang lalu", "Rasa sakitnya ", " dari 10", "Gejalanya semakin parah ketika saya ", "Gejalanya semakin membaik ketika saya ", "Pernah konsultasi ke dokter lain dan diberi obat yaitu "]
    }

    func loadAnswers(complaint: Complaint) {
        currentComplaint = complaint
        isUpdating = true
    }

    func generateNewComplaint() {
        currentComplaint = Complaint(user: dataSource.fetchUserData()!, symptoms: [SymptomsDetail](), summary: "Halo Dokter. Saya merasakan _____.", answers: ["_____", "_____", "_____", "_____", "_____", "_____", "_____"])
        isUpdating = false
    }

    func deleteComplaint(complaint: Complaint) {
        dataSource.delete(complaint: complaint)
        complaints.removeAll(where: { $0.id == complaint.id })
    }
}
