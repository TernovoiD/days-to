//
//  HomeView.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 22.01.2023.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var eventsVM: EventsViewModel
    @State var showAddEventView: Bool = false
    @State var search: String = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(eventsVM.events) { event in
                    EventRowView(event: event)
                }
            }
            .padding(.horizontal)
            .shadow(color: .black, radius: 3, y: 3)
            .searchable(text: $search)
            .navigationTitle("Upcoming")
            .toolbar {
                ToolbarItem {
                    addEventButton
                }
            }
            .sheet(isPresented: $showAddEventView) {
                AddEventView(isPresented: $showAddEventView)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(EventsViewModel())
    }
}

extension HomeView {
    
    var addEventButton: some View {
        Button {
            showAddEventView = true
        } label: {
            Image(systemName: "plus")
        }
    }
}
