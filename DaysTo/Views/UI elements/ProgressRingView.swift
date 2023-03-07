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
    
    var ringColor: Color {
        let procent = Double(leftProgress) / Double(allProgress)
        switch procent {
        case 0...0.25:
            return Color.green
        case 0.25...0.5:
            return Color.mint
        case 0.5...0.75:
            return Color.yellow
        case 0.75...1.0:
            return Color.orange
            
        default:
            return Color.indigo
        }
    }
    
    var percent: Double {
        return Double(allProgress - leftProgress) / Double(allProgress) * 100
    }
    
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
                .foregroundColor(ringColor)
                .overlay {
                    Text("\(String(Int(percent)))%")
                        .font(.title3)
                        .foregroundColor(.white)
                }
        }
        .frame(maxWidth: ringSize, maxHeight: ringSize)
    }
}

struct ProgressRingView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.indigo.ignoresSafeArea()
            ProgressRingView(allProgress: 34, leftProgress: 1, ringSize: 60, ringWidth: 10)
        }
    }
}
