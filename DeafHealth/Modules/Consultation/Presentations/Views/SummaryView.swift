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
    @EnvironmentObject var userDataViewModel: UserDataViewModel

    @State private var showingSaveModal = false
    @State private var complaintName = ""

    @State private var painSeverity = ""

    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                Text("Ringkasan Keluhan")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .bold()
            }
            Spacer().frame(height: DecimalConstants.d16 + DecimalConstants.d8)

            HStack {
                VStack(alignment: .trailing) {
                    VStack {
                        Text(complaintViewModel.answers[0])
                    }.padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(AppColors.blueMedium)
                        .cornerRadius(5)
                        .foregroundColor(.white)

                    // TODO: body part

                    if complaintViewModel.answers[1] != "" {
                        VStack {
                            Text(complaintViewModel.answers[1])
                        }.padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(AppColors.blueMedium)
                            .cornerRadius(5)
                            .foregroundColor(.white)
                    }

                    Text("Rasa sakit \n\(painSeverity) (\(complaintViewModel.answers[3]) / 10)").padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(AppColors.blueMedium)
                        .cornerRadius(5)
                        .foregroundColor(.white)
                }.bold()

                // TODO: body part

                if complaintViewModel.answers[1] == "" {
//                    Image("\(complaintViewModel.answers[0])")
                    Image("Pusing").resizable().aspectRatio(contentMode: .fit).frame(width: 185)
                } else {
                    Image("LK \(complaintViewModel.answers[1])").resizable().aspectRatio(contentMode: .fit).frame(width: 185)
                }

            }.padding(.horizontal, 10)
                .padding(.vertical, DecimalConstants.d16)
                .frame(width: 361, alignment: .topLeading)
                .background(.white)
                .cornerRadius(DecimalConstants.r15)
                .overlay(
                    RoundedRectangle(cornerRadius: DecimalConstants.r15)
                        .inset(by: -0.5)

                        // TODO: benerin warna graynya
                        .stroke(.gray, lineWidth: 1)
                )

            Spacer().frame(height: DecimalConstants.d8 + DecimalConstants.d4)

            VStack(alignment: .leading) {
                Text("Keluhan Saya").bold()

                Spacer().frame(height: DecimalConstants.d16)

                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        Text("•")
                        Text("\(complaintViewModel.getSummary(for: 0))")
                            + Text("\(complaintViewModel.answers[0]).".lowercased()).bold().foregroundColor(AppColors.blueMedium)
                    }

                    HStack(alignment: .top) {
                        Text("•")
                        Text("\(complaintViewModel.getSummary(for: 1))") + Text("\(complaintViewModel.answers[2])".lowercased()).bold().foregroundColor(AppColors.blueMedium) + Text("\(complaintViewModel.getSummary(for: 2))")
                    }

                    HStack(alignment: .top) {
                        Text("•")
                        Text("\(complaintViewModel.getSummary(for: 3))") + Text("\(complaintViewModel.answers[3])".lowercased()).bold().foregroundColor(AppColors.blueMedium) + Text("\(complaintViewModel.getSummary(for: 4))")
                    }

                    HStack(alignment: .top) {
                        Text("•")
                        Text("\(complaintViewModel.getSummary(for: 5))") + Text("\(complaintViewModel.answers[4])".lowercased()).bold().foregroundColor(AppColors.blueMedium)
                    }

                    HStack(alignment: .top) {
                        Text("•")
                        Text("\(complaintViewModel.getSummary(for: 6))") + Text("\(complaintViewModel.answers[5])".lowercased()).bold().foregroundColor(AppColors.blueMedium)
                    }

                    HStack(alignment: .top) {
                        Text("•")
                        if complaintViewModel.answers[6] == "Tidak ada riwayat konsultasi sebelumnya" {
                            Text("\(complaintViewModel.answers[6])".lowercased()).bold().foregroundColor(AppColors.blueMedium)
                        } else {
                            Text("\(complaintViewModel.getSummary(for: 7))") + Text("\(complaintViewModel.answers[6])".lowercased()).bold().foregroundColor(AppColors.blueMedium)
                        }
                    }
                }
                .padding(.horizontal, DecimalConstants.d16)

            }.padding(.horizontal, 10)
                .padding(.vertical, DecimalConstants.d16)
                .frame(width: 361, alignment: .topLeading)
                .background(.white)
                .cornerRadius(DecimalConstants.r15)
                .overlay(
                    RoundedRectangle(cornerRadius: DecimalConstants.r15)
                        .inset(by: -0.5)

                        // TODO: benerin warna graynya
                        .stroke(.gray, lineWidth: 1)
                )

            Spacer().frame(height: DecimalConstants.d16)

            HStack {
//                Text("adsf")
            }.frame(width: 361, alignment: .topLeading)
                .background(.white)
                .cornerRadius(DecimalConstants.r15)
                .overlay(
                    RoundedRectangle(cornerRadius: DecimalConstants.r15)
                        .inset(by: -0.5)

                        // TODO: benerin warna graynya
                        .stroke(.gray, lineWidth: 1)
                )

            Spacer()

            Button(AppLabel.saveButton) {
                showingSaveModal = true
            }
            .frame(width: 363, height: 52)
            .background(Color(red: 0.25, green: 0.48, blue: 0.68))
            .cornerRadius(25)
            .foregroundColor(Color("FFFFFF"))
        }
        .onAppear {
            if complaintViewModel.answers[3] == "1" || complaintViewModel.answers[3] == "2" || complaintViewModel.answers[3] == "3" {
                painSeverity = "Rendah"
            } else if complaintViewModel.answers[3] == "4" || complaintViewModel.answers[3] == "5" || complaintViewModel.answers[3] == "6" {
                painSeverity = "Sedang"
            } else {
                painSeverity = "Tinggi"
            }
        }
        .sheet(isPresented: $showingSaveModal) {
            SaveComplaintModal(complaintName: $complaintName) {
                // Action for saving the complaint
                complaintViewModel.saveComplaint(userData: userDataViewModel.currentUser!, name: complaintName)
                coordinator.popToRoot()
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
            .background(AppColors.blueMedium)
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
