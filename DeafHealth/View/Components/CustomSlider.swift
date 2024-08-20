//
//  CustomSlider.swift
//  DeafHealth
//
//  Created by Alifiyah Ariandri on 20/08/24.
//

import SwiftUI

struct CustomSlider: View {
    @Binding var value: Double
    var range: ClosedRange<Double>
    var step: Double
    var label: () -> Text
    var minimumValueLabel: () -> Text
    var maximumValueLabel: () -> Text
    
    let placeholderHeight: CGFloat = 4
    let knobSize: CGSize = .init(width: 26, height: 26)
    let ticksSize: CGSize = .init(width: 1, height: 8)
    
    let placeholderColor: Color = .init(UIColor.systemGray4)
    let ticksColor: Color = .white
    var progressColor: Color = .accentColor
    let knobColor: Color = .white
    
    @EnvironmentObject var complaintViewModel: ComplaintViewModel

    private var maxTicks: Int {
        let totalSteps = (range.upperBound - range.lowerBound) / step
        return Int(totalSteps) + 1
    }
    
    var body: some View {
        VStack {
            HStack {
                label()
                Spacer()
            }
            
            HStack {
                GeometryReader { geometry in
                    let placeholderWidth = geometry.size.width - knobSize.width
                    
                    ZStack(alignment: .center) {
                        Capsule()
                            .fill(placeholderColor)
                            .frame(width: placeholderWidth, height: placeholderHeight)
                            .overlay(alignment: .leading, content: {
                                Capsule().fill(progressColor)
                                    .frame(width: CGFloat(self.normalizedValue) * placeholderWidth, height: placeholderHeight)
                            })
                        
                        HStackDots(diameter: ticksSize.height - 4, maxDots: maxTicks, inSet: true).fill(ticksColor)
                            .offset(x: knobSize.width / 2)
                            .padding(.trailing, knobSize.width)
                        
                        HStack {
                            VStack {
                                ZStack {
                                    Image("bubble")
                                        .frame(width: knobSize.width, height: knobSize.height)
                                        .shadow(color: .gray.opacity(0.4), radius: 3, x: 2, y: 2).offset(x: self.knobOffset(width: geometry.size.width - knobSize.width))
                                    
                                    Text("\(Int(value))")
                                        .frame(width: knobSize.width, height: knobSize.height)
                                        .offset(x: self.knobOffset(width: geometry.size.width - knobSize.width), y: -9)
                                }
                                
                                Circle().fill(knobColor)
                                    .frame(width: knobSize.width, height: knobSize.height)
                                    .shadow(color: .gray.opacity(0.4), radius: 3, x: 2, y: 2)
                                    .offset(x: self.knobOffset(width: geometry.size.width - knobSize.width))
                            }
                            .gesture(
                                DragGesture()
                                    .onChanged { gesture in
                                        self.updateValue(from: gesture.location.x, geometry)
                                    }
                            )
                            .offset(y: -16)
                            Spacer()
                        }
                    }
                }
                .frame(height: knobSize.height)
            }
            .frame(height: knobSize.height + 16)
        }
    }
    
    private var normalizedValue: Double {
        return (value - range.lowerBound) / (range.upperBound - range.lowerBound)
    }
    
    private func knobOffset(width: CGFloat) -> CGFloat {
        let stepCount = (range.upperBound - range.lowerBound) / step
        let tickWidth = width / CGFloat(stepCount)
        let currentStep = (value - range.lowerBound) / step
        let offset = tickWidth * CGFloat(currentStep)
        return offset
    }
    
    private func updateValue(from touchLocation: CGFloat, _ geometry: GeometryProxy) {
        let stepCount = (range.upperBound - range.lowerBound) / step
        let tickWidth = (geometry.size.width - knobSize.width) / CGFloat(stepCount)
        let knobX = max(0, min(abs(touchLocation - knobSize.width / 2), geometry.size.width - knobSize.width))
        
        let newValue = range.lowerBound + Double(round(knobX / tickWidth)) * step
        value = max(range.lowerBound, min(newValue, range.upperBound))
    }
}

struct HStackDots: Shape {
    var diameter: CGFloat = 8.0 // 4
    var candidates: Set<Int> = []
    var maxDots: Int = 6 // 10
    var inSet: Bool = false // true
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let actualMaxDots = max(maxDots, 1) // 10
        
        let spacing = inSet ? (rect.width - diameter) / CGFloat(actualMaxDots - 1) : rect.width / CGFloat(actualMaxDots - 1)
        
        for i in 0 ..< actualMaxDots {
            if candidates.isEmpty || candidates.contains(i) {
                let xPosition = inSet ? spacing * CGFloat(i) * diameter / 4 : spacing * CGFloat(i)
                let yPosition = rect.midY
                
                path.addEllipse(in: CGRect(x: xPosition - diameter / 2, y: yPosition - diameter / 2, width: diameter, height: diameter))
            }
        }
        
        return path
    }
}
