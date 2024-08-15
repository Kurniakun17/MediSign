//
//  CommuncationPage.swift
//  DeafHealth
//
//  Created by Kurnia Kharisma Agung Samiadjie on 14/08/24.
//

import SwiftUI

enum Role: String, CaseIterable, Identifiable {
    case user = "User"
    case doctor = "Doctor"

    var id: String { rawValue }
}

struct Message: Identifiable, Equatable {
    var id = UUID()
    var role: Role
    var body: String

    init(id: UUID = UUID(), role: Role, body: String) {
        self.id = id
        self.role = role
        self.body = body
    }
}

struct CommuncationPage: View {
    @State var messages: [Message] = [
        Message(role: .user, body: "Hai namaku kurnia "),
        Message(role: .user, body: "Hai namaku kurnia "),
        Message(role: .user, body: "Hai namaku kurnia "),
        Message(role: .user, body: "Hai namaku kurnia "),
        Message(role: .user, body: "Hai namaku kurnia "),
        Message(role: .user, body: "Hai namaku kurnia "),
        Message(role: .user, body: "Hai namaku kurnia "),
        Message(role: .user, body: "Hai namaku kurnia "),
        Message(role: .user, body: "Hai namaku kurnia "),
        Message(role: .user, body: "Hai namaku kurnia "),
        Message(role: .user, body: "Hai namaku kurnia "),
    ]
    @State var inputValue = ""
    @State var role: Role = .user

    var body: some View {
        VStack {
            ScrollViewReader {
                proxy in
                ScrollView(.vertical) {
                    VStack(spacing: 8) {
                        ForEach(messages, id: \.self.id) {
                            message in
                            VStack(alignment: .trailing) {
                                Text(message.body)
                                    .padding()
                                    .background(message.role == .user ? .green.opacity(0.3) : .blue.opacity(0.3))
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                            }
                            .frame(maxWidth: .infinity, alignment: message.role == .user ? .trailing : .leading)
                            .padding(.horizontal, 16)
                            .transition(.move(edge: message.role == .user ? .trailing : .leading))
                            .transition(.scale)
                        }
                    }
                    Color.clear
                        .frame(height: 1)
                        .id("Bottom")
                }
                .onChange(of: messages) { _ in
                    // Scroll to the bottom whenever messages change
                    withAnimation {
                        proxy.scrollTo("Bottom", anchor: .bottom)
                    }
                }
            }

            Spacer()

            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 16) {
                    Button(action: {
                        role = .user
                    }) {
                        Text("User")
                            .foregroundStyle(.white)
                    }
                    .padding(8)
                    .fontWeight(.semibold)
                    .background(role == .user ? .green : .gray)
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                    Button(action: {
                        role = .doctor
                    }) {
                        Text("Doctor")
                            .foregroundStyle(.white)
                    }
                    .padding(8)
                    .fontWeight(.semibold)
                    .background(role == .user ? .gray : .blue.opacity(0.8))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }

//                Picker("Select Role", selection: $role) {
//                    ForEach(Role.allCases) { role in
//                        Text(role.rawValue)
//                            .tag(role)
//                    }
//                }
//                .pickerStyle(SegmentedPickerStyle())
//                .padding()
//
                HStack {
                    TextField("Message", text: $inputValue)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 12)
                            .stroke(.gray, lineWidth: 1))
                        .autocorrectionDisabled()
                    Button(action: {
                        withAnimation {
                            messages.append(Message(role: role, body: inputValue))
                        }
                        inputValue = ""
                    }) {
                        Image(systemName: "paperplane")
                            .foregroundStyle(.white)
                    }
                    .padding()
                    .background(inputValue.isEmpty ? .gray : (role == .user ?.green : .blue.opacity(0.8)))
                    .disabled(inputValue.isEmpty)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .padding()
        }
    }
}

#Preview {
    CommuncationPage()
}
