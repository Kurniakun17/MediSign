//
//  SymptomSeverityView.swift
//  DeafHealth
//
//  Created by Anthony on 16/08/24.
//

import SwiftUI

struct SymptomSeverityView: View {
    @EnvironmentObject var coordinator: Coordinator
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var complaintViewModel: ComplaintViewModel

    @State private var selectedSeverity: String = ""
    @State private var isAnswerProvided: Bool = false
    
    @State var sliderValue: Double = 1.0
    @State var sliderValue2: Double = 2.0

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                SegmentedProgressBar(totalSteps: 8, currentStep: 4)
                    .padding(.horizontal)

                HStack {
                    Button(action: {
                        coordinator.popToRoot()
                        coordinator.push(page: .consultationMenuView)
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color("black"))
                    }
                    .padding(.leading)

                    Spacer()
                }
            }
            .padding(.top, 16)
            .padding(.bottom, 16)

            VStack(spacing: 0) {
                Text("Seberapa parah gejalanya?")
                    .font(.title3)
                    .multilineTextAlignment(.center)
            }
            Spacer()
            
            CustomSlider(
                value: $sliderValue,
                range: 1 ... 10,
                step: 1,
                label: {
                    Text("")
                },
                minimumValueLabel: {
                    Text("1")
                        .font(.body.smallCaps()).bold()
                },
                maximumValueLabel: {
                    Text("10")
                        .font(.body).bold()
                }
            )
            .accentColor(.blue)
            .padding(.horizontal)

            // Example severity selection
            Button(action: {
                selectedSeverity = "4"
                isAnswerProvided = true
//                complaintViewModel.updateAnswer(for: 3, with: selectedSeverity)
            }) {
                Text("4")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }

            Spacer()

            // Green overlay at the bottom with buttons
            VStack(spacing: 16) {
                Text("Hasil Susun Keluhan")
                    .font(.headline)
                    .bold()
                    .padding(.top, 8)
                    .padding(.leading, 32)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text(complaintViewModel.getSummary(for: 3))
                    .font(.subheadline)
                    .padding(.bottom, 8)
                    .padding(.leading, 32)
                    .frame(maxWidth: .infinity, alignment: .leading)

                HStack(spacing: 16) {
                    Button("Kembali") {
                        coordinator.pop() // Navigate back to ConsultationMenuView
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("green"))
                    .cornerRadius(25)
                    .foregroundColor(Color("FFFFFF"))

                    Button("Lanjutkan") {
                        coordinator.push(page: .symptomWorseningFactors)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isAnswerProvided ? Color("light-green-button") : Color.gray)
                    .cornerRadius(25)
                    .foregroundColor(Color("FFFFFF"))
                    .disabled(!isAnswerProvided) // Disable the button if no answer is provided
                }
                .padding(.horizontal, 32)
            }
            .padding(.top, 32)
            .padding(.bottom, 32)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color("light-green"))
                    .edgesIgnoringSafeArea(.bottom)
            )
            .cornerRadius(25, corners: [.topLeft, .topRight])
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SymptomSeverityView()
        .environmentObject(Coordinator())
        .environmentObject(ComplaintViewModel(datasource: LocalDataSource.shared))
}

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
    let ticksColor: Color = .secondary
    let progressColor: Color = .accentColor
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
                minimumValueLabel()
                
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
                            Circle().fill(knobColor)
                                .frame(width: knobSize.width, height: knobSize.height)
                                .shadow(color: .gray.opacity(0.4), radius: 3, x: 2, y: 2)
                                .offset(x: self.knobOffset(width: geometry.size.width - knobSize.width))
                                .gesture(
                                    DragGesture()
                                        .onChanged { gesture in
                                            self.updateValue(from: gesture.location.x, geometry)
                                        }
                                )
                            Spacer()
                        }
                    }
                }
                .frame(height: knobSize.height)
                
                maximumValueLabel()
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
        
        complaintViewModel.updateAnswer(for: 3, with: "\(Int(newValue))")
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
