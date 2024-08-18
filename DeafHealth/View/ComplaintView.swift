//
//  ComplaintView.swift
//  DeafHealth
//
//  Created by Anthony on 16/08/24.
//

import SwiftUI

struct ComplaintView: View {
    @EnvironmentObject var coordinator: Coordinator
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var complaintViewModel: ComplaintViewModel

    @State private var selectedComplaint: String = ""
    @State private var isAnswerProvided: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                SegmentedProgressBar(totalSteps: 8, currentStep: 1)
                    .padding(.horizontal)

                HStack {
                    Spacer()  // Just a placeholder since this is the first view
                }
            }
            .padding(.top, 16)
            .padding(.bottom, 16)

            VStack(spacing: 0) {
                Text("Apa keluhan utama yang")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                Text("Anda rasakan?")
                    .font(.title3)
                    .multilineTextAlignment(.center)
            }
            Spacer()

            // Example complaint selection
            Button(action: {
                selectedComplaint = "Nyeri"
                isAnswerProvided = true
                complaintViewModel.updateAnswer(for: 0, with: selectedComplaint)
            }) {
                Text("Nyeri")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }

            Spacer()

            // Green overlay at the bottom with buttons
            VStack(spacing: 16) {
                Text("Hasil Susun Keluhan")
                    .font(.headline)
                    .bold()
                    .padding(.top, 8)
                    .padding(.leading, 32)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text(complaintViewModel.getSummary(for: 0))
                    .font(.subheadline)
                    .padding(.bottom, 8)
                    .padding(.leading, 32)
                    .frame(maxWidth: .infinity, alignment: .leading)

                HStack(spacing: 16) {
                    Button("Kembali") {
                        dismiss()  // Go back to home view
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("green"))
                    .cornerRadius(25)
                    .foregroundColor(Color("FFFFFF"))

                    Button("Lanjutkan") {
                        coordinator.push(page: .selectBodyPart)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isAnswerProvided ? Color("light-green-button") : Color.gray)
                    .cornerRadius(25)
                    .foregroundColor(Color("FFFFFF"))
                    .disabled(!isAnswerProvided)  // Disable the button if no answer is provided
                }
                .padding(.horizontal, 32)
            }
            .padding(.top, 32)
            .padding(.bottom, 32)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color("light-green"))
                    .edgesIgnoringSafeArea(.bottom)
            )
            .cornerRadius(25, corners: [.topLeft, .topRight])
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarBackButtonHidden(true)
    }
}

// CornerRadius on specific corners using a RoundedRectangle background
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct SegmentedProgressBar: View {
    var totalSteps: Int
    var currentStep: Int

    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<totalSteps, id: \.self) { index in
                Rectangle()
                    .frame(height: 3)
                    .frame(width: 30)
                    .foregroundColor(index < self.currentStep ? Color("dark-green") : Color("light-green"))
                    .cornerRadius(4)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    ComplaintView()
        .environmentObject(Coordinator())
        .environmentObject(ComplaintViewModel(datasource: LocalDataSource.shared))
}
