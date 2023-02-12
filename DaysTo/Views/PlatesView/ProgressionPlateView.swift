//
//  ProgressionPlateView.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 08.02.2023.
//

import SwiftUI

struct ProgressionPlateView: View {
    @EnvironmentObject var daysToVM: DaysToViewModel
    var body: some View {
        GeometryReader { proxy in
            plate
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                .rotation3DEffect(.degrees(proxy.frame(in: .global).minX / -10), axis: (x: 0, y: 1, z: 0))
                .shadow(color: Color.black.opacity(0.6), radius: 5, x: 0, y: 5)
                .blur(radius: abs(proxy.frame(in: .global).minX) / 50)
                .overlay(
                    VStack {
                        Text("Days until next")
                            .font(.system(size: 40).weight(.black))
                        Spacer()
                    }
                        .foregroundStyle(LinearGradient(colors: [.orange, .white], startPoint: .leading, endPoint: .trailing))
                        .offset(y: -20)
                        .offset(x: proxy.frame(in: .global).minX)
                )
                .padding()
        }
    }
    
    var plate: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                ProgressRingView(allProgress: daysToVM.daysInCurrentMonth(),
                                 leftProgress: daysToVM.daysLeftInCurrentMonth(),
                                 ringSize: 60,
                                 ringWidth: 10)
                Text("Month")
            }
            HStack {
                ProgressRingView(allProgress: daysToVM.daysInCurrentYear(),
                                 leftProgress: daysToVM.daysLeftInCurrentYear(),
                                 ringSize: 60,
                                 ringWidth: 10)
                Text("Year")
            }
        }
        .font(.largeTitle.weight(.medium))
        .padding(.horizontal)
        .padding(.vertical, 40)
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 250)
        .foregroundStyle(
            LinearGradient(colors: [.white, .white.opacity(0.7)], startPoint: .leading, endPoint: .trailing)
        )
        .background(
            .ultraThinMaterial
        )
    }
}

struct ProgressionPlateView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressionPlateView()
            .environmentObject(DaysToViewModel())
            .background(
                LinearGradient(colors: [.indigo, .purple], startPoint: .top, endPoint: .bottom)
            )
    }
}
