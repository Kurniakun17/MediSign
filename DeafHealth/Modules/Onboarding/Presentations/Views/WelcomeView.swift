//
//  WelcomeView.swift
//  DeafHealth
//
//  Created by Anthony on 22/08/24.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var coordinator: Coordinator

    var body: some View {
        ZStack {
            Image(ImageLabel.onboardingBackground)
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 32) {
                Image(ImageLabel.mainLogo)
                    .resizable()
                    .frame(width: 322.77, height: 192.66)
                    .offset(x: 0, y: 60)
                    .padding(.bottom, DecimalConstants.d16 * 1.7)
                
                Text(AppLabel.appName)
                    .font(.custom("Algance", size: 28.32))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color("blue-med2"))
                    .padding(.horizontal, 20)
                    .padding(.top, DecimalConstants.d16 * 3)
                
                Text(AppLabel.appSlogan)
                    .font(.custom("Algance", size: 45))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .padding(.top, DecimalConstants.d16)
                    .foregroundColor(Color("blue-med2"))
                
                Text(AppLabel.appLongSlogan)
                    .font(.custom("SF Pro", size: 16))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                    .padding(.top, DecimalConstants.d8)
                    .foregroundColor(Color("blue-med2"))
                
                
                Button(action: {
                    coordinator.push(page: .onboardingName)
                }) {
                    Text(AppLabel.continueButton)
                        .frame(maxWidth: .infinity, maxHeight: .infinity) 
                        .foregroundColor(.white)
                        .background(Color.clear)
                }
                .frame(width: 363, height: 52)
                .background(Color(red: 0.25, green: 0.48, blue: 0.68))
                .cornerRadius(25)
                .padding(.top, DecimalConstants.d16 * 4)
            }
        }
    }
}

#Preview {
    WelcomeView()
        .environmentObject(Coordinator())
}
