//
//  SearchPlateView.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 08.02.2023.
//

import SwiftUI

struct SearchPlateView: View {
    @EnvironmentObject var daysToVM: DaysToViewModel
    @FocusState var selectedField: FocusText?
    @Binding var selectedTab: Int
    
    enum FocusText {
        case searchField
    }

    var body: some View {
        GeometryReader { proxy in
            plate
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                .rotation3DEffect(.degrees(proxy.frame(in: .global).minX / -10), axis: (x: 0, y: 1, z: 0))
                .shadow(color: Color.black.opacity(0.6), radius: 5, x: 0, y: 5)
                .blur(radius: abs(proxy.frame(in: .global).minX) / 50)
                .overlay(
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(LinearGradient(colors: [.orange, .white], startPoint: .leading, endPoint: .trailing))
                        .offset(x: 60, y: -80)
                        .frame(width: 120)
                        .offset(x: proxy.frame(in: .global).minX)
                        .onTapGesture {
                            selectedField = .none
                        }
                )
                .padding()
        }
    }

    var plate: some View {
        VStack(alignment: .leading, spacing: 8) {
            Spacer()
            Text("Filter:")
                .font(.headline.weight(.black))
            HStack {
                Button {
                    withAnimation(.easeInOut) {
                        daysToVM.showFavoriteOnly.toggle()
                        selectedField = .none
                    }
                } label: {
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(daysToVM.showFavoriteOnly ? .yellow : .white)
                        Text("Favorite")
                    }
                    .font(.callout.weight(.bold))
                    .padding(5)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                }
                Button {
                    withAnimation(.easeInOut) {
                        daysToVM.sevenDays.toggle()
                        selectedField = .none
                    }
                } label: {
                    HStack {
                        Image(systemName: "timer")
                            .foregroundColor(daysToVM.sevenDays ? .cyan : .white)
                        Text("7 Days")
                    }
                    .font(.callout.weight(.bold))
                    .padding(5)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                }

            }
            .padding(.bottom, 20)
            Text("Looking for something special?")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.subheadline.weight(.black))
                .padding(.horizontal)
            HStack {
                TextField("Search...", text: $daysToVM.textToSearch)
                    .padding()
                    .font(.headline.weight(.black))
                    .foregroundColor(.white)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    .autocorrectionDisabled(true)
                    .focused($selectedField, equals: .searchField)
                    .submitLabel(.search)
                    .onSubmit {
                        selectedField = .none
                    }
                    .onChange(of: selectedTab) { newValue in
                        selectedField = .none
                    }
                Button {
                    withAnimation(.easeInOut) {
                        daysToVM.textToSearch = ""
                        selectedField = .none
                    }
                } label: {
                    Image(systemName: "xmark")
                        .font(.headline)
                        .frame(maxWidth: 20)
                }
                .padding()

            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 250)
        .foregroundStyle(
            LinearGradient(colors: [.white, .white.opacity(0.7)], startPoint: .leading, endPoint: .trailing)
        )
        .background(
            .ultraThinMaterial
        )
        .onTapGesture {
            selectedField = .none
        }
    }

}

struct SearchPlateView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPlateView(selectedTab: .constant(3))
            .environmentObject(DaysToViewModel())
            .background(
                LinearGradient(colors: [.indigo, .purple], startPoint: .top, endPoint: .bottom)
            )
    }
}
