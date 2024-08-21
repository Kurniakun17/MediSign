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
            Image("homepage-background")
            Image("homepage-background")

            VStack {
                VStack(spacing: 16) {
                    HStack {
                        HStack(spacing: 4) {
                            Text("Halo,")
                                .fontWeight(.bold)
                                .font(.title2)
                            // TODO: Change name
                            Text("Ibun Iwawan")
                                .font(.title2)
                        }

                        Spacer()

                        Circle()
                            .fill(.gray.opacity(0.3))
                            .frame(width: 40, height: 40)
                    }

                    VStack(spacing: 24) {
                        Button(action: {
                            coordinator.push(page: .consultationMenuView)
                        }) {
                            ZStack {
                                Image("logo")
                                    .resizable()
                                    .frame(width: 207, height: 180)
                                    .offset(x: 100, y: 50)

                                VStack(spacing: 20) {
                                    Image(systemName: "plus.square.fill")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 60))
                                    Text("Tambah keluhan")
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
                            VStack(spacing: 8) {
                                Image(systemName: "stethoscope.circle.fill")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 36))
                                Text("Mulai Komunikasi")
                                    .foregroundStyle(.white)
                                    .fontWeight(.semibold)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, 24)
                        .padding(.bottom, 24)
                        .background(.lightBlue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }

                    HStack {}
                        .padding(.top, 30)

                    VStack(alignment: .leading) {
                        Text("Riwayat Keluhan")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.bottom, 12)

//                        TODO: Complaint History
                        HStack(spacing: 18) {
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
                        .padding(16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.gray.opacity(0.3), lineWidth: 1)
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
