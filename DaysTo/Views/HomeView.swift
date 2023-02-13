//
//  HomeView.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 29.01.2023.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("isSignedIn") var isSignedIn: Bool = false
    @AppStorage("backgroundScheme") var backgroundScheme: String = "Background Purple Waves"
    @EnvironmentObject var authentification: AuthentificationViewModel
    @EnvironmentObject var daysToVM: DaysToViewModel
    @Namespace var namespace
    @State var hasScrolled: Bool = false
    @State var showStatusBar: Bool = true
    @State var backgroundScroll: CGFloat = 0
    var columns = [GridItem(.adaptive(minimum: 300), spacing: 20)]
    
    var body: some View {
        ZStack {
            Image(backgroundScheme)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaleEffect(1.8)
                .rotationEffect(.degrees(180))
                .offset(y: backgroundScroll)
                .zIndex(-1)
            
            ScrollView {
                
                scrollDetector
                
                infoPlates
                
                events
                
//                if daysToVM.showEditEventView {
//                    fakeEvents
//                } else {
//                    fakeEvents
//                    events
//                }
                
                Color.clear
                    .frame(height: 100)
            }
            .scrollIndicators(.hidden)
            .coordinateSpace(name: "scroll")
            .safeAreaInset(edge: .top, content: { Color.clear.frame(height: 70) })
            .overlay(NavBarView(namespace: namespace, title: "DaysTo", hasScrolled: $hasScrolled))
            .scaleEffect(daysToVM.showAddEventView || daysToVM.showSettingsView || !isSignedIn ? 0.8 : 1)
            
            if daysToVM.showAddEventView || daysToVM.showSettingsView || daysToVM.showEditEventView || !isSignedIn {
                Color.clear.background(.ultraThinMaterial)
            }
            
            if daysToVM.showEditEventView {
                editEvent
            }
            
            AddEventView()
                .offset(y: daysToVM.showAddEventView ? 0 : 1000)
            SettingsView(namespace: namespace)
                .offset(y: daysToVM.showSettingsView ? 0 : 1000)
            
            if !isSignedIn {
                AuthentificationView()
            }
            
        }
        .statusBarHidden(daysToVM.showEditEventView)
        .toolbarColorScheme(.light, for: .navigationBar)
        .background(.ultraThinMaterial)
    }
    
    var scrollDetector: some View {
        GeometryReader { proxy in
            Color.clear.preference(key: ScrollPreferenceKey.self, value: proxy.frame(in: .named("scroll")).minY)
        }
        .onPreferenceChange(ScrollPreferenceKey.self, perform: { value in
            backgroundScroll = calculateBackgroundScroll(value)
            withAnimation(.easeInOut) {
                hasScrolled = value < 0 ? true : false
            }
        })
    }
    
    var infoPlates: some View {
        TabView {
            if daysToVM.sortedEvents.count == 0 {
                StartPlateView()
            }
            if daysToVM.sortedEvents.count > 1 {
                SearchPlateView()
            }
            if daysToVM.sortedEvents.filter({ $0.isFavorite }).count > 0 {
                FavoritePlateView()
            }
            if daysToVM.sortedEvents.count > 1 {
                UpcomingPlateView()
            }
            ProgressionPlateView()
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .frame(height: 315)
    }
    
    var editEvent: some View {
        ForEach(daysToVM.sortedEvents) { event in
            if event == daysToVM.eventToEdit {
                EditEventView(namespace: namespace)
            }
        }
    }
    
    var events: some View {
        LazyVGrid(columns: columns, spacing: 15) {
            ForEach(daysToVM.eventsfilterdBySearch(events: daysToVM.sortedEvents)) { event in
                EventPanel(namespace: namespace, event: event)
            }
        }
        .padding(.horizontal)
    }
    
    var fakeEvents: some View {
        LazyVGrid(columns: columns, spacing: 15) {
            ForEach(daysToVM.sortedEvents) { event in
                Rectangle()
                    .fill(.indigo)
                    .frame(height: 70)
                    .cornerRadius(15)
                    .opacity(1)
            }
        }
        .padding(.horizontal)
    }
    
    func calculateBackgroundScroll(_ proxy: CGFloat) -> CGFloat {
        if proxy >= 0 {
            return 0
        } else if proxy < -300 {
            return -300 * 1.3
        } else {
            return proxy * 1.3
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(DaysToViewModel())
            .environmentObject(AuthentificationViewModel())
    }
}

struct EventPanel: View {
    let namespace: Namespace.ID
    let event: EventEntity
    @EnvironmentObject var daysToVM: DaysToViewModel
    @State var showFullPanel: Bool = false
    @State var showDeleteConfirmationAlert: Bool = false
    @AppStorage("askBeforeDelete") var askBeforeDelete: Bool = true
    @AppStorage("appColorScheme") var appColorScheme: String = "Indigo"
    
    var body: some View {
        VStack(alignment: .leading) {
            panelContent
            if daysToVM.selectedEvent == event {
                additionalInfo
                    .padding(.top, 20)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundColor(.white)
        .background(
            Color(appColorScheme)
                .matchedGeometryEffect(id: "background\(event.uuidString ?? "default")", in: namespace)
        )
        .mask(
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .matchedGeometryEffect(id: "mask\(event.uuidString ?? "default")", in: namespace)
        )
        .shadow(color: . black.opacity(0.5), radius: 3, y: 3)
        .onTapGesture {
            withAnimation(.easeInOut) {
                daysToVM.selectedEvent = daysToVM.selectedEvent == event ? nil : event
            }
        }
    }
    
    var panelContent: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text(event.name ?? "No name")
                        .animatableFont(size: 18, weight: .heavy, design: .default)
                        .matchedGeometryEffect(id: "title\(event.uuidString ?? "default")", in: namespace)
                    if event.isFavorite {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                    }
                }
                .font(.headline)
                Text("\(daysToVM.getDaysLeft(toEvent: event)) days")
                    .animatableFont(size: 16, weight: .heavy, design: .default)
                    .opacity(0.6)
            }
            Spacer()
            Image(systemName: "chevron.down")
                .rotationEffect(.degrees(daysToVM.selectedEvent == event ? 180 : 0))
            
        }
    }
    
    var additionalInfo: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 5) {
                Text("Date: \(event.date?.formatted(date: .abbreviated, time: .omitted) ?? Date().formatted())")
                if event.information == "" {
                    Text("No additional information")
                } else {
                    Text(event.information ?? "No INFO")
                }
            }
            Spacer()
            RoundedRectangle(cornerRadius: 1, style: .continuous)
                .padding(.top, 5)
                .frame(maxWidth: 1, maxHeight: 90)
                .opacity(0.3)
            eventPanelButtons
        }
    }
    
    var eventPanelButtons: some View {
        VStack(alignment: .leading, spacing: 10) {
            Button {
                withAnimation(.easeInOut) {
                    daysToVM.eventToEdit = event
                    daysToVM.showEditEventView = true
                }
            } label: {
                Label("Edit", systemImage: "pencil")
            }
            Button {
                withAnimation(.spring()) {
                    daysToVM.changeEventFavoriteStatus(event)
                }
            } label: {
                Label("Favorite", systemImage: event.isFavorite ? "star.fill" : "star")
            }
            Button {
                if askBeforeDelete {
                    withAnimation(.easeInOut) {
                        showDeleteConfirmationAlert = true
                    }
                } else {
                    withAnimation(.easeInOut) {
                        daysToVM.deleteEvent(event)
                    }
                }
            } label: {
                Label("Delete", systemImage: "trash")
            }
            .alert("Are you shoure to delete this Event?", isPresented: $showDeleteConfirmationAlert) {
                Button("DELETE", role: .destructive) {
                    withAnimation(.easeInOut) {
                        daysToVM.deleteEvent(event)
                    }
                }
            }
        }
    }
}

struct EditEventView: View {
    let namespace: Namespace.ID
    @EnvironmentObject var daysToVM: DaysToViewModel
    @AppStorage("appColorScheme") var appColorScheme: String = "Indigo"
    
    var body: some View {
            VStack(alignment: .leading) {
                topPanel
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 300)
            .foregroundColor(.white)
            .background(
                Color(appColorScheme)
                    .matchedGeometryEffect(id: "background\(daysToVM.eventToEdit?.uuidString ?? "default")", in: namespace)
            )
            .mask(
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .matchedGeometryEffect(id: "mask\(daysToVM.eventToEdit?.uuidString ?? "default")", in: namespace)
            )
            .ignoresSafeArea()
            .shadow(color: .black, radius: 3, y: 3)
            .onTapGesture {
                withAnimation(.closePlate) {
                    daysToVM.showEditEventView = false
                }
            }
            .padding()
    }
    
    var topPanel: some View {
        HStack {
                Text(daysToVM.eventToEdit?.name ?? "No name")
                    .animatableFont(size: 18, weight: .heavy, design: .default)
                    .matchedGeometryEffect(id: "title\(daysToVM.eventToEdit?.uuidString ?? "default")", in: namespace)
                Spacer()
                Button {
                    withAnimation(.easeInOut) {
                        daysToVM.showEditEventView = false
                    }
                } label: {
                    Image(systemName: "xmark")
                        .font(.title3.weight(.black))
                        .padding(10)
                        .foregroundColor(.primary)
                        .background(.thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                }
        }
    }
}
