//
//  PlatesView.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 14.02.2023.
//

import SwiftUI

struct PlatesView: View {
    @AppStorage("selectedTabIndex") var selectedTabIndex: Int = 0
    var body: some View {
        TabView(selection: $selectedTabIndex) {
            StartPlateView()
                .tag(0)
            SearchPlateView()
                .tag(1)
            FavoritePlateView()
                .tag(2)
            ProgressionPlateView()
                .tag(3)
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .frame(height: 315)
    }
}

struct PlatesView_Previews: PreviewProvider {
    static var previews: some View {
        PlatesView()
    }
}
