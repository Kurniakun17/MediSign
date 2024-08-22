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
            .fill(Color.clear) // Transparent fill
            .frame(width: 40, height: 40) // Adjust size as needed
            .contentShape(Circle()) // Ensures the entire circle area is tappable
            .position(x: x, y: y)
            .onTapGesture {
                selectedBodyPart.wrappedValue = bodyPart
                isAnswerProvided.wrappedValue = true
            }
    }
}
