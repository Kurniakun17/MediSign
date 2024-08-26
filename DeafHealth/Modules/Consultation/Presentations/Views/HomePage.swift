//
//  HomePage.swift
//  DeafHealth
//
//  Created by Kurnia Kharisma Agung Samiadjie on 21/08/24.
//

import SwiftUI

struct HomePage: View {
    @EnvironmentObject var coordinator: Coordinator
    @EnvironmentObject var complaintViewModel: ComplaintViewModel
    @EnvironmentObject var userDataViewModel: UserDataViewModel
    @State private var userName: String = ""
    @State private var profileImage: UIImage? = nil

    var body: some View {
        ZStack {
            Image(ImageLabel.homepageBackground)
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            ScrollView(.vertical) {
                VStack {
                    VStack(spacing: 16) {
                        HStack {
                            HStack(spacing: 4) {
                                Text(AppLabel.consultationGreeting)
                                    .fontWeight(.bold)
                                    .font(.title2)
                                Text(userName.isEmpty ? "Guest" : userName)
                                    .font(.title2)
                            }

                            Spacer()

                            HStack {
                                Button(action: {
                                    coordinator.push(page: .userProfile)
                                }) {
                                    if let profileImage = profileImage {
                                        Image(uiImage: profileImage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 40, height: 40)
                                            .clipShape(Circle())
                                    } else {
                                        Circle()
                                            .fill(Color.gray.opacity(DecimalConstants.d2 * 0.15))
                                            .frame(width: 40, height: 40)
                                            .overlay(
                                                Image(systemName: "person.fill")
                                                    .foregroundColor(.white)
                                            )
                                    }
                                }

                                Button(action: {
                                    userDataViewModel.deleteAllData()
                                    complaintViewModel.deleteAllData()
                                }) {
                                    Image(systemName: "trash")
                                }
                            }
                        }

                        VStack(spacing: DecimalConstants.d16) {
                            Button(action: {
                                coordinator.push(page: .consultationMenuView)
                            }) {
                                ZStack {
                                    Image(ImageLabel.logo)
                                        .resizable()
                                        .frame(width: 207, height: 180)
                                        .offset(x: 100, y: 50)

                                    VStack(spacing: DecimalConstants.d8 * 2.5) {
                                        Image(systemName: "plus.square.fill")
                                            .foregroundStyle(.white)
                                            .font(.system(size: 60))
                                        Text(AppLabel.addConsultation)
                                            .foregroundStyle(.white)
                                            .fontWeight(.semibold)
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .background(.bluePurple)
                            .clipShape(RoundedRectangle(cornerRadius: 10))

                            Button(action: {
                                coordinator.push(page: .communication)
                            }) {
                                VStack(spacing: DecimalConstants.d8) {
                                    Image(systemName: "stethoscope.circle.fill")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 36))
                                    Text(AppLabel.startCommunication)
                                        .foregroundStyle(.white)
                                        .fontWeight(.semibold)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.top, DecimalConstants.d8 * 3)
                                .padding(.bottom, DecimalConstants.d8 * 3)
                                .background(.lightBlue)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }

                        HStack {}
                            .padding(.top, 30)

                        VStack(alignment: .leading) {
                            Text(AppLabel.consultationHistory)
                                .font(.title2)
                                .fontWeight(.semibold)
                                .padding(.bottom, DecimalConstants.d8 * 1.5)

                            ForEach(complaintViewModel.complaints, id: \.self.id) { complaintData in
                                ComplaintHistoryCard(complaintData: complaintData)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 20)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 70)
            }
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .onAppear {
            loadUserData()
        }
    }

    private func loadUserData() {
        if let userData = LocalDataSource.shared.fetchUserData() {
            userName = userData.name
            if let imageData = userData.profileImageData {
                profileImage = UIImage(data: imageData)
            } else {
                profileImage = nil
            }
        } else {
            userName = "Guest"
            profileImage = nil
        }
    }
}

#Preview {
    HomePage()
        .environmentObject(Coordinator())
}
