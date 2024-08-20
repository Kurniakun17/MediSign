//
//  MessageViewModel.swift
//  DeafHealth
//
//  Created by Kurnia Kharisma Agung Samiadjie on 20/08/24.
//

import AVFAudio
import Foundation

class MessageViewModel: ObservableObject {
    @Published var messages: [Message] = [
        Message(role: .user, body: "Hai namaku kurnia "),
    ]
    @Published var inputValue = ""
    @Published var role: Role = .user
    @Published var isRecording = false
    @Published private var speechSynthesizer: AVSpeechSynthesizer?

    init(messages: [Message] = [
        Message(role: .user, body: "Hai namaku kurnia "),
    ], inputValue: String = "", role: Role = .user, isRecording: Bool = false, speechSynthesizer: AVSpeechSynthesizer? = nil, SpeechViewModel: SpeechViewModel = SpeechViewModel()) {
        self.messages = messages
        self.inputValue = inputValue
        self.role = role
        self.isRecording = isRecording
        self.speechSynthesizer = speechSynthesizer
    }

    func addMessage(newMessage: Message) {
        messages.append(newMessage)
    }

    func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "id_ID")

        speechSynthesizer = AVSpeechSynthesizer()
        speechSynthesizer?.speak(utterance)
    }
}
