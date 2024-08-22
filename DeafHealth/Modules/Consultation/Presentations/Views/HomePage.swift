//
//  HomePage.swift
//  DeafHealth
//
//  Created by Kurnia Kharisma Agung Samiadjie on 21/08/24.
//

import SwiftUI

struct HomePage: View {
    @EnvironmentObject var coordinator: Coordinator

    var body: some View {
        ZStack {
            Image(ImageLabel.homepageBackground)

            VStack {
                VStack(spacing: 16) {
                    HStack {
                        HStack(spacing: 4) {
                            Text(AppLabel.consultationGreeting)
                                .fontWeight(.bold)
                                .font(.title2)
                            // TODO: Change name
                            Text("Ibun Iwawan")
                                .font(.title2)
                        }

                        Spacer()

                        Circle()
                            .fill(.gray.opacity(DecimalConstants.d2 * 0.15))
                            .frame(width: 40, height: 40)
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
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, DecimalConstants.d8 * 3)
                        .padding(.bottom, DecimalConstants.d8 * 3)
                        .background(.lightBlue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }

                    HStack {}
                        .padding(.top, 30)

                    VStack(alignment: .leading) {
                        Text(AppLabel.consultationHistory)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.bottom, DecimalConstants.d8 * 1.5)

                        HStack(spacing: DecimalConstants.d8 * 2.25) {
                            RoundedRectangle(cornerRadius: 8)
                                .frame(width: 60, height: 60)
                            VStack(alignment: .leading) {
                                Text("Nyeri otot bahu")
                                    .font(.title3)
                                Text("Selasa, 13 Agustus 2024")
                                    .font(.footnote)
                                    .foregroundStyle(.gray)
                            }
                        }
                        .padding(DecimalConstants.d16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.gray.opacity(DecimalConstants.d2 * 0.15), lineWidth: 1)
                        )
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }

                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 70)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    HomePage()
}
