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

    init(messages: [Message] = [
        Message(role: .user, body: "Hai namaku kurnia "),
    ], inputValue: String = "", role: Role = .user, isRecording: Bool = false) {
        self.messages = messages
        self.inputValue = inputValue
        self.role = role
        self.isRecording = isRecording
    }

    func addMessage(newMessage: Message) {
        messages.append(newMessage)
    }
    
    func updateInputValue(with text: String){
        self.inputValue += text
    }
}
