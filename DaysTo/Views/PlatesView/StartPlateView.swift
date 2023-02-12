//
//  StartPlateView.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 08.02.2023.
//

import SwiftUI

struct StartPlateView: View {
    @EnvironmentObject var daysToVM: DaysToViewModel
    var body: some View {
        GeometryReader { proxy in
            plate
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                .rotation3DEffect(.degrees(proxy.frame(in: .global).minX / -10), axis: (x: 0, y: 1, z: 0))
                .shadow(color: Color.black.opacity(0.6), radius: 5, x: 0, y: 5)
                .blur(radius: abs(proxy.frame(in: .global).minX) / 50)
                .overlay(
                    Image(systemName: "person.3")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(LinearGradient(colors: [.orange, .white], startPoint: .leading, endPoint: .trailing))
                        .offset(x: 60, y: -80)
                        .frame(width: 250)
                        .offset(x: proxy.frame(in: .global).minX)
                )
                .padding()
        }
    }
    
    var plate: some View {
        VStack(alignment: .leading, spacing: 8) {
            Spacer()
            Button {
                withAnimation(.easeInOut) {
                    daysToVM.showAddEventView = true
                }
            } label: {
                Label("Tap to add Event", systemImage: "plus")
                    .font(.title.weight(.medium))
                    .padding(5)
                    .background(
                        LinearGradient(colors: [.indigo, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
            }
            Text("- Track days left to future events")
            Text("- Track days left to anniversary of events in past")
        }
        .font(.footnote.weight(.medium))
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

struct StartPlateView_Previews: PreviewProvider {
    static var previews: some View {
        StartPlateView()
            .environmentObject(DaysToViewModel())
            .background(
                LinearGradient(colors: [.indigo, .purple], startPoint: .top, endPoint: .bottom)
            )
    }
}
