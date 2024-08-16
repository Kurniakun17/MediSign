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

struct CommunicationPage: View {
    @State var messages: [Message] = [
        Message(role: .user, body: "Hai namaku kurnia "),
//        Message(role: .user, body: "Hai namaku kurnia "),
//        Message(role: .user, body: "Hai namaku kurnia "),
//        Message(role: .user, body: "Hai namaku kurnia "),
//        Message(role: .user, body: "Hai namaku kurnia "),
//        Message(role: .user, body: "Hai namaku kurnia "),
//        Message(role: .user, body: "Hai namaku kurnia "),
//        Message(role: .user, body: "Hai namaku kurnia "),
//        Message(role: .user, body: "Hai namaku kurnia "),
//        Message(role: .user, body: "Hai namaku kurnia "),
//        Message(role: .user, body: "Hai namaku kurnia "),
    ]
    @State var inputValue = ""
    @State var role: Role = .user
    @State var isRecording = false
    @StateObject var speechRecognizer = SpeechRecognizer()

    func startRecording() {
        isRecording = true
        speechRecognizer.startTranscribe()

        DispatchQueue.main.asyncAfter(deadline: .now() + 60) {
            if isRecording {
                stopRecording()
            }
        }
    }

    func stopRecording() {
        isRecording = false
        speechRecognizer.stopTranscribing()
        inputValue = speechRecognizer.transcript
        speechRecognizer.transcript = ""
    }

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
                HStack {
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

                    Spacer()

                    Button(action: {
                        role = .doctor
                        if isRecording {
                            stopRecording()

                        } else {
                            startRecording()
                        }
                    }) {
                        Text(isRecording ? "Stop Recording" : "Record")
                            .foregroundStyle(.white)
                            .padding(8)
                            .background(isRecording ? .blue : .red)
                            .fontWeight(.bold)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }

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
    CommunicationPage()
}
