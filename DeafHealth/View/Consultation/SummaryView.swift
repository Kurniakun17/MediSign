//
//  SummaryView.swift
//  DeafHealth
//
//  Created by Anthony on 16/08/24.
//

import SwiftUI

struct SummaryView: View {
    @EnvironmentObject var coordinator: Coordinator
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var complaintViewModel: ComplaintViewModel

    @State private var showingSaveModal = false
    @State private var complaintName = ""

    var body: some View {
        VStack(spacing: 0) {

            VStack(spacing: 0) {
                Text("Ringkasan Keluhan")
                    .font(.title3)
                    .multilineTextAlignment(.center)
            }
            Spacer()

            // Summary details...
            VStack(spacing: 16) {
                Text(complaintViewModel.complaintSummary)
                    .font(.body)
                    .padding()
                    .multilineTextAlignment(.leading)

                HStack(spacing: 16) {
                    Button("Simpan") {
                        showingSaveModal = true
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("green"))
                    .cornerRadius(25)
                    .foregroundColor(Color("FFFFFF"))
                }
                .padding(.horizontal, 32)
            }
            .padding(.top, 32)
            .padding(.bottom, 32)

        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $showingSaveModal) {
            SaveComplaintModal(complaintName: $complaintName) {
                // Action for saving the complaint
                complaintViewModel.saveComplaint()
                dismiss()  // Save and go back to home view
            }
        }
    }
}

struct SaveComplaintModal: View {
    @Binding var complaintName: String
    var onSave: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Simpan Keluhan")
                .font(.title2)
                .bold()

            TextField("Nama Keluhan", text: $complaintName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Simpan") {
                onSave()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color("green"))
            .cornerRadius(25)
            .foregroundColor(Color("FFFFFF"))
            .padding(.horizontal, 32)

            Spacer()
        }
        .padding()
    }
}

struct SaveComplaintAlert: View {
    @Binding var complaintName: String
    var onSave: () -> Void
    var onCancel: () -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 16) {
                Text("Simpan Keluhan")
                    .font(.headline)
                    .padding(.top, 16)

                Text("Masukkan judul untuk keluhan ini")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                TextField("Judul Keluhan", text: $complaintName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                Divider()

                HStack {

                    Button(action: {
                        onSave()
                    }) {
                        Text("Simpan")
                            .frame(maxWidth: .infinity)
                    }
                    .padding(.horizontal)
                    .foregroundColor(.blue)
                }
            }
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .frame(maxWidth: 300)
        }
    }
}

#Preview {
    SummaryView()
        .environmentObject(Coordinator())
        .environmentObject(ComplaintViewModel(datasource: LocalDataSource.shared))
}
