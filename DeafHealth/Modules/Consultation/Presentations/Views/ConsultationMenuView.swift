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
    @Environment(\.presentationMode) var presentationMode
    @State private var currentQuestionIndex: Int? = nil

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.custom("SF Pro", size: 20))
                            .foregroundColor(.black)
                            .imageScale(.large)
                    }
                    .padding(.leading, -5)

                    Spacer()

                    Text(AppLabel.addConsultation)
                        .font(.system(size: 20))
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding(.horizontal)
                .padding(.trailing, 25)
                .frame(height: 44)

                ForEach(0 ..< 6) { index in
                    QuestionButtonView(index: index, currentQuestionIndex: $currentQuestionIndex)
                }

                Spacer(minLength: -8)

                SaveComplaintButton()
                    .disabled(!allQuestionsAnswered())
            }
            .padding()
            .background(Color.clear)
        }
        .background(
            Image("consultation-menu-background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
        .navigationBarBackButtonHidden(true)
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
            PreviousConsultationView()
        default:
            EmptyView()
        }
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
                Text("\(index + 1)")
                    .font(.custom("SF Pro", size: 28))
                    .bold()
                    .foregroundColor(.white)
                    .frame(width: 42, height: 42)
                    .background(isQuestionActive(at: index) ? Color("blue-active") : Color("blue-disabled"))
                    .cornerRadius(12)
                    .padding(8)

                Text(questionText(for: index))
                    .font(.custom("SF Pro", size: 16))
                    .foregroundColor(.white)
                    .padding(.leading, 2)
                    .padding(.vertical, 12)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 12)
            .padding(.vertical, 12)
            .background(isQuestionActive(at: index) ? Color("dark-blue") : Color("light-blue"))
            .cornerRadius(16)
            .multilineTextAlignment(.leading)
        }
        .disabled(!isQuestionActive(at: index))
        .padding(.horizontal, 3)
    }

    func questionText(for index: Int) -> String {
        switch index {
        case 0:
            return "Halo, Dokter. Saya merasakan \(complaintViewModel.answers[0])."
        case 1:
            return "Saya merasakan gejala ini sejak \(complaintViewModel.answers[1])."
        case 2:
            return "Rasa sakitnya \(complaintViewModel.answers[2]) dari 10."
        case 3:
            return "Gejalanya semakin parah ketika saya \(complaintViewModel.answers[3])."
        case 4:
            return "Gejalanya semakin membaik ketika saya \(complaintViewModel.answers[4])."
        case 5:
            return "Pernah melakukan konsultasi ke dokter lain dan diberikan obat berupa \(complaintViewModel.answers[5])."
        default:
            return ""
        }
    }

    func isQuestionActive(at index: Int) -> Bool {
        if index == 0 {
            return true
        }
        return !(complaintViewModel.answers[index] == "_____")
    }
}

struct SaveComplaintButton: View {
    @EnvironmentObject var coordinator: Coordinator

    var body: some View {
        Button("Simpan Keluhan") {
            coordinator.push(page: .summary)
        }
        .font(.custom("SF Pro", size: 16))
        .frame(width: 363)
        .padding(.vertical, 16)
        .background(Color("blue-button"))
        .cornerRadius(25)
        .foregroundColor(Color.white)
        .disabled(true)
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
