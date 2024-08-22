//
//  AgeGenderInputView.swift
//  DeafHealth
//
//  Created by Anthony on 22/08/24.
//

import SwiftUI

struct AgeGenderInputView: View {
    @EnvironmentObject var coordinator: Coordinator
    @State private var age: String = ""
    @State private var gender: Gender = .male

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
                        .padding(.top, DecimalConstants.d16 * 5.5)
                    
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
                        .padding(.bottom, DecimalConstants.d16)
                    
                    Text(AppLabel.ageQuestion)
                        .font(.system(size: 20, weight: .bold))
                    
                    TextField("Enter your age", text: $age)
                        .padding(DecimalConstants.d8 * 2.125)
                        .padding(.vertical, -DecimalConstants.d8 * 0.625)
                        .font(.custom("SF Pro", size: 14))
                        .background(Color.white)
                        .cornerRadius(25)
                        .padding(.horizontal)
                        .padding(.bottom, DecimalConstants.d16)
                }
                .padding(.bottom, DecimalConstants.d16 * 2.5)

                
                // Gender Question and Picker
                VStack(spacing: 16) {
                    Text(AppLabel.genderQuestion)
                        .font(.system(size: 20, weight: .bold))
                    
                    Picker("Gender", selection: $gender) {
                        Text("Male").tag(Gender.male)
                        Text("Female").tag(Gender.female)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal, DecimalConstants.d16)
                }
                
                Spacer()
                
                Button(action: {
                    if var userData = LocalDataSource.shared.fetchUserData() {
                        userData.age = age
                        userData.gender = gender
                        LocalDataSource.shared.modelContext.insert(userData)
                        try? LocalDataSource.shared.modelContext.save()
                    }
                    coordinator.push(page: .onboardingAllergy)
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
    AgeGenderInputView()
        .environmentObject(Coordinator())
}
