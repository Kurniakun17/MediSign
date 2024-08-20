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
    @State private var currentQuestionIndex: Int? = nil

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("Tambah Keluhan")
                    .font(.title3)
                    .bold()
                    .padding(.top, 32)

                Spacer()

                ForEach(0 ..< 6) { index in
                    QuestionButtonView(index: index, currentQuestionIndex: $currentQuestionIndex)
                }

                Spacer()

                Button("Lanjutkan") {
                    currentQuestionIndex = 0 // Open the first question sheet
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(allQuestionsAnswered() ? Color.blue : Color.gray)
                .cornerRadius(25)
                .foregroundColor(Color.white)
                .disabled(!allQuestionsAnswered())
            }
            .padding()
            .background(Color("background"))
        }
        .sheet(item: $currentQuestionIndex) { index in
            sheetView(for: index)
        }
    }

    func allQuestionsAnswered() -> Bool {
        return complaintViewModel.answers.allSatisfy { !$0.isEmpty }
    }

    @ViewBuilder
    func sheetView(for index: Int) -> some View {
        switch index {
        case 0:
            ComplaintView()
        case 1:
            SymptomStartTimeView()
        case 2:
            SymptomSeverityView()
        case 3:
            SymptomWorseningFactorsView()
        case 4:
            SymptomImprovementFactorsView()
        case 5:
            AdditionalComplaintsView()
        default:
            EmptyView()
        }
    }

    private func goToNextQuestion() {
        guard let current = currentQuestionIndex else { return }
        currentQuestionIndex = current + 1
    }
}

struct QuestionButtonView: View {
    @EnvironmentObject var coordinator: Coordinator
    @EnvironmentObject var complaintViewModel: ComplaintViewModel
    let index: Int
    @Binding var currentQuestionIndex: Int?

    var body: some View {
        Button(action: {
            currentQuestionIndex = index
        }) {
            HStack {
                ZStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 42, height: 42)
                        .background(Color(red: 0.43, green: 0.56, blue: 0.76))
                        .cornerRadius(12)

                    Text("\(index + 1)")
                        .bold()
                        .foregroundColor(.white)
                        .padding(24)
                        .cornerRadius(8)
                }

                Text(questionText(for: index))
                    .foregroundColor(.white)
                    .padding(.leading, 8)
                    .multilineTextAlignment(.leading)

                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding()
            .background(isQuestionActive(at: index) ? Color(red: 0.35, green: 0.49, blue: 0.71) : Color.gray)
            .cornerRadius(8)
        }
    }

    func questionText(for index: Int) -> String {
        switch index {
        case 0:
            return "Selamat pagi, Dokter. Saya merasakan " + complaintViewModel.answers[0]
        case 1:
            return "Saya merasakan gejala ini sejak " + complaintViewModel.answers[1] + " yang lalu."
        case 2:
            return "Rasa sakitnya " + complaintViewModel.answers[2] + " dari 10."
        case 3:
            return "Gejalanya semakin parah ketika saya " + complaintViewModel.answers[3]
        case 4:
            return "Gejalanya semakin membaik ketika saya " + complaintViewModel.answers[4]
        case 5:
            return "Pernah melakukan konsultasi ke dokter lain dan diberikan obat berupa " + complaintViewModel.answers[5]
        default:
            return ""
        }
    }

    func isQuestionActive(at index: Int) -> Bool {
        if index == 0 {
            return true
        }
        return !(complaintViewModel.answers[index - 1] == "_____")
    }
}

#Preview {
    ConsultationMenuView()
        .environmentObject(Coordinator())
        .environmentObject(ComplaintViewModel(datasource: LocalDataSource.shared))
}

extension Int: Identifiable {
    public var id: Int { self }
}

#Preview {
    ConsultationMenuView()
        .environmentObject(Coordinator())
        .environmentObject(ComplaintViewModel(datasource: LocalDataSource.shared))
}
