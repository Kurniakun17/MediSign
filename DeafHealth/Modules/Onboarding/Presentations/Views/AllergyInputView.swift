//
//  AllergyInputView.swift
//  DeafHealth
//
//  Created by Anthony on 22/08/24.
//

import SwiftUI

struct AllergyInputView: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("isOnboardingCompleted") private var isOnboardingCompleted: Bool = false

    @State private var foodAllergy: String = ""
    @State private var drugAllergy: String = ""
    @State private var conditionAllergy: String = ""

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
                        .padding(.top, DecimalConstants.d8)
                }
                .padding(.bottom, DecimalConstants.d16 * 4.5)
                
                VStack(spacing: 16) {
                    Text(AppLabel.nameSlogan)
                        .font(.custom("SF Pro", size: 14))
                        .multilineTextAlignment(.center)
                    
                    Text(AppLabel.allergyQuestion)
                        .font(.system(size: 20, weight: .bold))
                        .padding(.vertical, DecimalConstants.d8)
                }

                VStack(spacing: 16) {
                    VStack(alignment: .center) {
                        Text(AppLabel.foodAllergy)
                            .font(.custom("SF Pro", size: 14))
                            .padding(.bottom, 2)
                        
                        TextField("Contoh: Udang", text: $foodAllergy)
                            .padding(DecimalConstants.d8 * 2.125)
                            .padding(.vertical, -DecimalConstants.d8 * 0.625)
                            .font(.custom("SF Pro", size: 14))
                            .background(Color.white)
                            .cornerRadius(25)
                            .padding(.horizontal)
                    }
                    .padding(.bottom, 16)
                    
                    VStack(alignment: .center) {
                        Text(AppLabel.drugAllergy)
                            .font(.custom("SF Pro", size: 14))
                            .padding(.bottom, 2)
                        
                        TextField("Contoh: Amoxilin", text: $drugAllergy)
                            .padding(DecimalConstants.d8 * 2.125)
                            .padding(.vertical, -DecimalConstants.d8 * 0.625)
                            .font(.custom("SF Pro", size: 14))
                            .background(Color.white)
                            .cornerRadius(25)
                            .padding(.horizontal)
                    }
                    .padding(.bottom, 16)
                    
                    VStack(alignment: .center) {
                        Text(AppLabel.conditionAllergy)
                            .font(.custom("SF Pro", size: 14))
                            .padding(.bottom, 2)
                        
                        TextField("Contoh: Debu dan Suhu Dingin", text: $conditionAllergy)
                            .padding(DecimalConstants.d8 * 2.125)
                            .padding(.vertical, -DecimalConstants.d8 * 0.625)
                            .font(.custom("SF Pro", size: 14))
                            .background(Color.white)
                            .cornerRadius(25)
                            .padding(.horizontal)
                    }
                    .padding(.bottom, 16)
                }
                
                Spacer()
                
                Button(action: {
                    if var userData = LocalDataSource.shared.fetchUserData() {
                        userData.foodAllergy = foodAllergy
                        userData.drugAllergy = drugAllergy
                        userData.conditionAllergy = conditionAllergy
                        LocalDataSource.shared.modelContext.insert(userData)
                        try? LocalDataSource.shared.modelContext.save()
                    }
                    isOnboardingCompleted = true
                    coordinator.push(page: .homepage)
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
    AllergyInputView()
        .environmentObject(Coordinator())
}
