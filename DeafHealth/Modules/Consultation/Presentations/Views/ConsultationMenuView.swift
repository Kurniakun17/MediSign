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

//                SaveComplaintButton()
//                    .disabled(!allQuestionsAnswered())
                Button("Simpan Keluhan") {
                    coordinator.push(page: .summary)
                }
                .font(.custom("SF Pro", size: 16))
                .frame(width: 363)
                .padding(.vertical, 16)
                .background(allQuestionsAnswered() ? Color(red: 0.25, green: 0.48, blue: 0.68) : Color("blue-button"))
                .cornerRadius(25)
                .foregroundColor(Color.white)
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
        for answer in complaintViewModel.answers {
            if answer == "_____" {
                return false
            }
        }
        return true
//        return complaintViewModel.answers.allSatisfy { !$0.isEmpty }
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

//                Text(questionText(for: index))
//                    .font(.custom("SF Pro", size: 16))
//                    .foregroundColor(.white)
//                    .padding(.leading, 2)
//                    .padding(.vertical, 12)
                questionText(for: index).foregroundColor(.white)
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

    func questionText(for index: Int) -> some View {
        switch index {
        case 0:
            return HStack {
                Text("\(complaintViewModel.getSummary(for: 0))") + Text("\(complaintViewModel.answers[0])").bold().underline()
            }
        case 1:
            return HStack {
                Text("\(complaintViewModel.getSummary(for: 1))") + Text("\(complaintViewModel.answers[2])").bold().underline() + Text("\(complaintViewModel.getSummary(for: 2))")
            }
        case 2:
            return HStack {
                Text("\(complaintViewModel.getSummary(for: 3))") + Text("\(complaintViewModel.answers[3])").bold().underline() + Text("\(complaintViewModel.getSummary(for: 4))")
            }
        case 3:
            return HStack {
                Text("\(complaintViewModel.getSummary(for: 5))") + Text("\(complaintViewModel.answers[4])").bold().underline()
            }
        case 4:
            return HStack {
                Text("\(complaintViewModel.getSummary(for: 6))") + Text("\(complaintViewModel.answers[5])").bold().underline()
            }
        case 5:
            return HStack {
                Text("\(complaintViewModel.getSummary(for: 7))") + Text("\(complaintViewModel.answers[6])").bold().underline()
            }
        default:
            return HStack {
                Text("") // Ensure the default case also returns an HStack
            }
        }
    }

    func isQuestionActive(at index: Int) -> Bool {
        if index == 0 {
            return true
        }
        else if index == 2 && complaintViewModel.answers[2].contains("_____") {
            return false
        }
        else if index == 1 && complaintViewModel.answers[2] != "_____" {
            return true
        }
        return !(complaintViewModel.answers[index] == "_____")
    }
}

//
// struct SaveComplaintButton: View {
//    @EnvironmentObject var coordinator: Coordinator
//    @Binding var isDisabled
//
//    var body: some View {
//        Button("Simpan Keluhan") {
//            coordinator.push(page: .summary)
//        }
//        .font(.custom("SF Pro", size: 16))
//        .frame(width: 363)
//        .padding(.vertical, 16)
//        .background(Color("blue-button"))
//        .cornerRadius(25)
//        .foregroundColor(Color.white)
//        .disabled(true)
//    }
// }

#Preview {
    ConsultationMenuView()
        .environmentObject(Coordinator())
        .environmentObject(ComplaintViewModel(datasource: LocalDataSource.shared))
}

extension Int: Identifiable {
    public var id: Int { self }
}
