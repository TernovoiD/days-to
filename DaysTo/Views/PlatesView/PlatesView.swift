//
//  PlatesView.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 14.02.2023.
//

import SwiftUI

struct PlatesView: View {
    var body: some View {
        TabView {
            StartPlateView()
            SearchPlateView()
            FavoritePlateView()
            //            if daysToVM.sortedEvents.count > 1 {
            //                UpcomingPlateView()
            //            }
            ProgressionPlateView()
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
