//
//  ConsultationMenuView.swift
//  DeafHealth
//
//  Created by Anthony on 18/08/24.
//

import SwiftUI

struct ConsultationMenuView: View {
    @EnvironmentObject var coordinator: Coordinator
    @EnvironmentObject var complaintViewModel: ComplaintViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("Tambah Keluhan")
                    .font(.title3)
                    .bold()
                    .padding(.top, 32)

                Spacer()

                ForEach(0..<8) { index in
                    QuestionButtonView(index: index)
                }

                Spacer()

                SaveComplaintButton()
                    .padding(.horizontal, 32)
                    .disabled(!allQuestionsAnswered())
            }
            .padding()
            .background(Color("background"))
        }
    }

    func allQuestionsAnswered() -> Bool {
        return complaintViewModel.answers.allSatisfy { !$0.isEmpty }
    }
}

struct QuestionButtonView: View {
    @EnvironmentObject var coordinator: Coordinator
    @EnvironmentObject var complaintViewModel: ComplaintViewModel
    let index: Int

    var body: some View {
        Button(action: {
            navigateToQuestion(at: index)
        }) {
            HStack {
                Text("\(index + 1)")
                    .bold()
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color("dark-green"))
                    .cornerRadius(8)

                Text(questionText(for: index))
                    .foregroundColor(.white)
                    .padding(.leading, 8)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(isQuestionActive(at: index) ? Color("light-green") : Color.gray)
            .cornerRadius(8)
        }
        .disabled(!isQuestionActive(at: index))
    }

    func questionText(for index: Int) -> String {
        switch index {
        case 0:
            return "Selamat pagi, Dokter. Saya merasakan _____." // First question full text
        case 1:
            return "di _____." // Only the second question text
        case 2:
            return "Saya merasakan gejala ini sejak _____." // Only the third question text
        case 3:
            return "Rasa sakitnya _____ dari 10." // Only the fourth question text
        case 4:
            return "Gejalanya semakin parah ketika saya _____." // Only the fifth question text
        case 5:
            return "Gejalanya semakin membaik ketika saya _____." // Only the sixth question text
        case 6:
            return "Terdapat keluhan lain berupa _____." // Only the seventh question text
        case 7:
            return "Pernah melakukan konsultasi ke dokter lain dan diberikan obat berupa _____." // Only the eighth question text
        default:
            return ""
        }
    }

    func navigateToQuestion(at index: Int) {
        switch index {
        case 0:
            coordinator.push(page: .mainComplaint)
        case 1:
            coordinator.push(page: .selectBodyPart)
        case 2:
            coordinator.push(page: .symptomStartTime)
        case 3:
            coordinator.push(page: .symptomSeverity)
        case 4:
            coordinator.push(page: .symptomWorseningFactors)
        case 5:
            coordinator.push(page: .symptomImprovementFactors)
        case 6:
            coordinator.push(page: .additionalComplaints)
        case 7:
            coordinator.push(page: .previousConsultation)
        default:
            break
        }
    }

    func isQuestionActive(at index: Int) -> Bool {
        // The first button is always active
        if index == 0 {
            return true
        }
        // Subsequent buttons are active only if the previous question is answered
        return !complaintViewModel.answers[index - 1].isEmpty
    }
}

struct SaveComplaintButton: View {
    @EnvironmentObject var coordinator: Coordinator

    var body: some View {
        Button("Simpan Keluhan") {
            coordinator.push(page: .summary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.blue)
        .cornerRadius(25)
        .foregroundColor(Color.white)
    }
}

#Preview {
    ConsultationMenuView()
        .environmentObject(Coordinator())
        .environmentObject(ComplaintViewModel(datasource: LocalDataSource.shared))
}
