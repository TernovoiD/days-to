//
//  FavoritePlateView.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 10.02.2023.
//

import SwiftUI

struct FavoritePlateView: View {
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
                        let scroll = proxy.frame(in: .global).minX
                                Text("Favorites")
                                .font(.system(size: 50).weight(.black))
                                .foregroundStyle(LinearGradient(colors: [.orange, .white], startPoint: .leading, endPoint: .trailing))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .offset(x: 20, y: -20)
                                .offset(x: scroll * 1.5)
                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(daysToVM.events.filter({ $0.isFavorite}).indices, id: \.self) { index in
                                    if index < 3 {
                                        let indexName = "\(index + 1).square"
                                        let eventName = daysToVM.events.filter({ $0.isFavorite})[index].name 
                                        HStack {
                                            Image(systemName: indexName)
                                            Text(eventName)
                                        }
                                            .font(.title)
                                            .offset(x: scroll * (Double(index) + 1))
                                    }
                                }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.white)
                        Spacer()
                    }
                        .padding(.horizontal)
                )
                .padding()
        }
    }

    var plate: some View {
        VStack(alignment: .leading, spacing: 8) {
            Spacer()
//            Button {
//
//            } label: {
//                Label("Show all", systemImage: "ellipsis.circle")
//                    .foregroundColor(.white)
//            }
        }
        .padding(.horizontal)
        .padding(.vertical)
        .frame(maxWidth: .infinity)
        .frame(height: 250)
        .foregroundStyle(
            LinearGradient(colors: [.white, .white.opacity(0.7)], startPoint: .leading, endPoint: .trailing)
        )
        .background(
            .ultraThinMaterial
        )
    }
}

struct FavoritePlateView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritePlateView()
            .background(
                LinearGradient(colors: [.indigo, .purple], startPoint: .top, endPoint: .bottom)
            )
            .environmentObject(DaysToViewModel())
    }
}
