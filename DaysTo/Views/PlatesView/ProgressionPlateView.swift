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
                .padding()
        }
    }
    
    var plate: some View {
        HStack {
            VStack(alignment: .center, spacing: 0) {
                ProgressRingView(allProgress: daysToVM.daysInCurrentMonth(),
                                 leftProgress: daysToVM.daysLeftInCurrentMonth(),
                                 ringSize: 110,
                                 ringWidth: 30)
                .padding()
                Text("Month")
                    .font(.largeTitle.weight(.bold))
                Text("Days left: \(daysToVM.daysLeftInCurrentMonth())")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.7))
            }
            Spacer()
            VStack(alignment: .center, spacing: 0) {
                ProgressRingView(allProgress: daysToVM.daysInCurrentYear(),
                                 leftProgress: daysToVM.daysLeftInCurrentYear(),
                                 ringSize: 110,
                                 ringWidth: 30)
                .padding()
                Text("Year")
                    .font(.largeTitle.weight(.bold))
                Text("Days left: \(daysToVM.daysLeftInCurrentYear())")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.7))
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 250)
        .glassyFont(textColor: .white)
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
