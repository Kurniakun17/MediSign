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

    var body: some View {
        VStack(spacing: 0) {
            SegmentedProgressBar(totalSteps: 8, currentStep: 1)
                .padding(.top, 32)
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

            // Green overlay at the bottom with buttons
            VStack(spacing: 16) {
                Text("Hasil Susun Keluhan")
                    .font(.headline)
                    .bold()
                    .padding(.top, 8)
                    .padding(.leading, 32)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text("Halo Dokter. Saya merasakan _____.")
                    .font(.subheadline)
                    .padding(.bottom, 8)
                    .padding(.leading, 32)
                    .frame(maxWidth: .infinity, alignment: .leading)

                HStack(spacing: 16) {
                    Button("Kembali") {
                        dismiss()  // Dismisses the sheet and returns to the home view
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("green"))
                    .cornerRadius(25)
                    .frame(width: (UIScreen.main.bounds.width - 64) * 0.353)  // 1/4 of the available width (64 is the total horizontal padding)
                    .foregroundColor(Color("FFFFFF"))

                    Button("Lanjutkan") {
                        coordinator.push(page: .selectBodyPart)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("light-green-button"))
                    .cornerRadius(25)
                    .frame(width: (UIScreen.main.bounds.width - 64) * 0.647)  // 3/4 of the available width (64 is the total horizontal padding)
                    .foregroundColor(Color("FFFFFF"))
                }
                .padding(.horizontal, 32)  // Matching the horizontal padding with the text above
            }
            .padding(.top, 32)  // Add some padding at the top for visual spacing
            .padding(.bottom, 32)  // Increase the padding at the bottom for height
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color("light-green"))
                    .edgesIgnoringSafeArea(.bottom)
            )
            .cornerRadius(25, corners: [.topLeft, .topRight])  // Rounded corners at the top left and right
        }
        .edgesIgnoringSafeArea(.bottom)  // Ensure the overlay fully covers the bottom of the screen
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
}
