//
//  NameInputView.swift
//  DeafHealth
//
//  Created by Anthony on 22/08/24.
//

import SwiftUI

struct NameInputView: View {
    @EnvironmentObject var coordinator: Coordinator
    @State private var name: String = ""

    var body: some View {
        ZStack {
            Image(ImageLabel.onboardingBackground)
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            VStack {
                VStack(spacing: 8) {
                    Image(ImageLabel.mainLogo)
                        .resizable()
                        .frame(width: 165, height: 98.48)
                        .padding(.top, DecimalConstants.d16 * 5.3)

                    Text(AppLabel.appName)
                        .font(.custom("Algance", size: 28.32))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("blue-med2"))
                }
                .padding(.bottom, DecimalConstants.d16 * 4)

                VStack(spacing: 16) {
                    Text(AppLabel.nameSlogan)
                        .font(.custom("SF Pro", size: 14))
                        .multilineTextAlignment(.center)

                    Text(AppLabel.nameQuestion)
                        .font(.custom("SF Pro", size: 20))
                        .multilineTextAlignment(.center)

                    TextField("Nama", text: $name)
                        .padding(DecimalConstants.d8 * 2.125)
                        .padding(.vertical, -DecimalConstants.d8 * 0.625)
                        .font(.custom("SF Pro", size: 14))
                        .background(Color.white)
                        .cornerRadius(25)
                        .padding(.horizontal)
                        .padding(.top, DecimalConstants.d16)
                }

                Spacer()

                Button(action: {
                    let newUserData =
                        LocalDataSource.shared.saveUserData(name: name, age: "", gender: .male, foodAllergy: nil, drugAllergy: nil, conditionAllergy: nil, profileImageData: nil)
                    coordinator.push(page: .onboardingAgeGender)
                }) {
                    Text(AppLabel.continueButton)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(width: 363, height: 52)
                .foregroundColor(Color.white)
                .background(Color(red: 0.25, green: 0.48, blue: 0.68))
                .cornerRadius(15)
                .padding(.bottom, DecimalConstants.d16 * 3.5)
            }
            .padding(.horizontal, DecimalConstants.d16)
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NameInputView()
        .environmentObject(Coordinator())
}
