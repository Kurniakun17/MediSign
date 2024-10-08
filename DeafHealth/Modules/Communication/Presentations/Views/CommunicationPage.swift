//
//  CommuncationPage.swift
//  DeafHealth
//
//  Created by Kurnia Kharisma Agung Samiadjie on 14/08/24.
//

import AVFoundation
import SwiftUI

struct CommunicationPage: View {
    @StateObject var messageViewModel = MessageViewModel()
    @StateObject var speechViewModel = SpeechViewModel()
    @StateObject var signLanguageInterpreterViewModel = SignLanguageInterpreterViewModel()
    @State var isKeyboardFocus = false
    @State var isShowingInterpreter = false

    var body: some View {
        VStack {
            // Chat History
            ScrollViewReader { proxy in
                ScrollView(.vertical) {
                    VStack(spacing: 12) {
                        ForEach(messageViewModel.messages, id: \.self.id) { message in
                            Button(action: {
                                speechViewModel.speak(text: message.body)
                            }) {
                                MessageBubble(message: message)
                            }
                        }
                    }
                    .padding(.horizontal, 16)

                    Color.clear
                        .frame(height: 1)
                        .id("Bottom")
                }
                .onChange(of: messageViewModel.messages) { _ in
                    // Scroll to the bottom whenever messages change
                    withAnimation {
                        proxy.scrollTo("Bottom", anchor: .bottom)
                    }
                }
            }
            .onTapGesture {
                UIApplication.shared.hideKeyboard()

                if speechViewModel.isRecording {
                    stopRecording()
                }

                if signLanguageInterpreterViewModel.isInterpreting {
                    signLanguageInterpreterViewModel.stopInterpreting()
                    isShowingInterpreter = false
                }
            }

            Spacer()

            // Keyboard unfocus and other UI
            VStack(alignment: .leading, spacing: 12) {
                if !isKeyboardFocus {
                    HStack(spacing: 8) {
                        Button(action: {
                            if messageViewModel.isRecording {
                                stopRecording()
                            } else {
                                startRecording()
                            }
                        }) {
                            Text("Dokter")
                            Image(systemName: "mic.circle.fill")
                        }
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(!messageViewModel.isRecording ? .gray.opacity(0.2) : .blue.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 12))

                        Button(action: {
                            if signLanguageInterpreterViewModel.isInterpreting {
                                signLanguageInterpreterViewModel.stopInterpreting()
                                isShowingInterpreter = false
                            } else {
                                signLanguageInterpreterViewModel.startInterpreting()
                                messageViewModel.role = .user
                                isShowingInterpreter = true
                            }
                        }) {
                            Text("Saya")
                            Image(systemName: "camera.circle.fill")
                        }
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(signLanguageInterpreterViewModel.isInterpreting ? .blue.opacity(0.2) : .gray.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .onChange(of: signLanguageInterpreterViewModel.recognizedText) { newText in
                            if newText != "" {
                                messageViewModel.inputValue = newText
                            }
                        }
                    }
                    .transition(.opacity)
                } else {
                    HStack(spacing: 8) {
                        Button(action: {
                            messageViewModel.role = .doctor
                        }) {
                            Text("Dokter").foregroundStyle(messageViewModel.role == .doctor ? .white : .black)
                            Image(systemName: "keyboard.fill")
                                .foregroundStyle(messageViewModel.role == .doctor ? .white : .black)
                        }
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(messageViewModel.role == .doctor ? .primaryBlue : .gray.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 12))

                        Button(action: {
                            messageViewModel.role = .user
                        }) {
                            Text("Saya")
                                .foregroundStyle(messageViewModel.role == .user ? .white : .black)
                            Image(systemName: "keyboard.fill")
                                .foregroundStyle(messageViewModel.role == .user ? .white : .black)
                        }
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(messageViewModel.role == .user ? .primaryBlue : .gray.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .transition(.opacity)
                }

                HStack {
                    TextField("Message", text: $messageViewModel.inputValue)
                        .padding()
                        .background(.gray.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .autocorrectionDisabled()

                    Button(action: {
                        withAnimation {
                            messageViewModel.addMessage(newMessage: Message(role: messageViewModel.role, body: messageViewModel.inputValue))
                        }
                        messageViewModel.inputValue = ""
                    }) {
                        Image(systemName: "paperplane")
                            .foregroundStyle(.white)
                    }
                    .padding()
                    .background(messageViewModel.inputValue.isEmpty ? .gray : .primaryBlue)
                    .disabled(messageViewModel.inputValue.isEmpty)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .padding()
        }

        .sheet(isPresented: $isShowingInterpreter) {
            SignLanguageSheet(isShowingInterpreter: $isShowingInterpreter)
                .environmentObject(signLanguageInterpreterViewModel)
        }

        .sheet(isPresented: $speechViewModel.isRecording, content: {
            SpeechSheet(stopRecording: stopRecording)
            
                .environmentObject(messageViewModel)
                .environmentObject(speechViewModel)
        })
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidShowNotification)) { _ in
            withAnimation {
                isKeyboardFocus = true
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidHideNotification)) { _ in
            withAnimation {
                isKeyboardFocus = false
            }
        }
    }

    func startRecording() {
        speechViewModel.isRecording = true
        speechViewModel.startTranscribe()

        DispatchQueue.main.asyncAfter(deadline: .now() + 60) {
            if speechViewModel.isRecording {
                stopRecording()
            }
        }
    }

    func stopRecording() {
        speechViewModel.isRecording = false
        speechViewModel.stopTranscribing()
        messageViewModel.role = .doctor
        messageViewModel.inputValue = speechViewModel.transcript
        speechViewModel.transcript = ""
        speechViewModel.audioLevels = Array(repeating: AudioLevel(level: 0.1), count: 50)
    }
}

#Preview {
    CommunicationPage()
}
