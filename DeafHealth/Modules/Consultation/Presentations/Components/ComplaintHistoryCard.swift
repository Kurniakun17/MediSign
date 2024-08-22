//
//  ComplaintHistoryCard.swift
//  DeafHealth
//
//  Created by Kurnia Kharisma Agung Samiadjie on 23/08/24.
//

import SwiftUI

struct ComplaintHistoryCard: View {
    @EnvironmentObject var complaintViewModel: ComplaintViewModel
    @EnvironmentObject var coordinator: Coordinator
    var complaintData: Complaint
    
    var body: some View {
        Button(action: {
            complaintViewModel.loadAnswers(complaint: complaintData)
            coordinator.push(page: .consultationMenuView)
        }) {
            HStack(spacing: DecimalConstants.d8 * 2.25) {
                Image("LK \(complaintData.answers[1])").resizable().aspectRatio(contentMode: .fit).frame(width: 60)

                VStack(alignment: .leading) {
                    Text(complaintData.name)
                        .font(.title3)
                    Text(complaintData.date.formattedDate())
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
    }
}


