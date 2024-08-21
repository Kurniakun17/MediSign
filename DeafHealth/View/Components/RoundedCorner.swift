//
//  RoundedCorner.swift
//  DeafHealth
//
//  Created by Anthony on 21/08/24.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func positionedCircle(x: CGFloat, y: CGFloat, bodyPart: String, selectedBodyPart: Binding<String>, isAnswerProvided: Binding<Bool>) -> some View {
        Circle()
            .fill(selectedBodyPart.wrappedValue == bodyPart ? Color.blue : Color.blue.opacity(0.7))
            .frame(width: 30, height: 30)
            .position(x: x, y: y)
            .onTapGesture {
                selectedBodyPart.wrappedValue = bodyPart
                isAnswerProvided.wrappedValue = true
            }
    }
}
