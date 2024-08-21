//
//  MessageBubble.swift
//  DeafHealth
//
//  Created by Kurnia Kharisma Agung Samiadjie on 20/08/24.
//

import SwiftUI

struct MessageBubble: View {
    var message: Message
    var body: some View {
        HStack(alignment: .top, spacing: 2) {
            if message.role == .doctor {
                Circle()
                    .fill(.primaryBlue)
                    .frame(width: 50, height: 50)
            }
            VStack(alignment: .trailing) {
                Text(message.body)
                    .foregroundStyle(.black)
                    .padding()
                    .background(.gray.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity, alignment: message.role == .user ? .trailing : .leading)
            .padding(.horizontal, 16)
            .transition(.move(edge: message.role == .user ? .trailing : .leading))

            if message.role == .user {
                Circle()
                    .fill(.primaryBlue)
                    .frame(width: 50, height: 50)
            }
        }
    }
}

#Preview {
    MessageBubble(message: Message(role: .doctor, body: "hai nama saya kurnia"))
}
