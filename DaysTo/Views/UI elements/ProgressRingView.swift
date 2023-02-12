//
//  ProgressRingView.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 08.02.2023.
//

import SwiftUI

struct ProgressRingView: View {
    let allProgress: Int
    let leftProgress: Int
    let ringSize: CGFloat
    let ringWidth: CGFloat
    @State var fill: Bool = false
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(style: StrokeStyle(lineWidth: ringWidth, lineCap: .round))
                .foregroundColor(.white.opacity(0.3))
            Circle()
                .trim(from: Double(leftProgress) / Double(allProgress))
                .stroke(style: StrokeStyle(lineWidth: ringWidth, lineCap: .round))
                .rotation(.degrees(-90))
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                .foregroundStyle(.linearGradient(colors: [.orange, .orange, .green], startPoint: .leading, endPoint: .trailing))
                .overlay {
                    Text("\(leftProgress)")
                        .font(.title3)
                        .foregroundColor(.white)
                }
        }
        .frame(maxWidth: ringSize, maxHeight: ringSize)
        .padding()
    }
}

struct ProgressRingView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            ProgressRingView(allProgress: 34, leftProgress: 5, ringSize: 60, ringWidth: 10)
        }
    }
}
