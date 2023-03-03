//
//  PlatesView.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 14.02.2023.
//

import SwiftUI

struct PlatesView: View {
    @EnvironmentObject var daysToVM: DaysToViewModel
    @AppStorage("selectedTabIndex") var selectedTabIndex: Int = 0
    var body: some View {
        
        ZStack {
            VStack {
                Spacer()
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .foregroundColor(.black.opacity(0.4))
                    .frame(width: 75, height: 15)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            }
            .frame(height: 275)
            content
        }
    }
    
    var content: some View {
        TabView(selection: $selectedTabIndex) {
            StartPlateView()
                .tag(0)
            SearchPlateView(selectedTab: $selectedTabIndex)
                .tag(1)
            FavoritePlateView()
                .tag(2)
            ProgressionPlateView()
                .tag(3)
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .frame(height: 310)
        .onTapGesture {
            withAnimation(.easeInOut) {
                daysToVM.openMenu = false
            }
        }
        .onChange(of: selectedTabIndex) { newValue in
            withAnimation(.easeInOut) {
                daysToVM.openMenu = false
                daysToVM.textToSearch = ""
                daysToVM.showFavoriteOnly = false
                daysToVM.sevenDays = false
            }
        }
    }
}

struct PlatesView_Previews: PreviewProvider {
    static var previews: some View {
        PlatesView()
            .environmentObject(DaysToViewModel())
    }
}
