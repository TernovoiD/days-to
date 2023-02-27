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
    @AppStorage("appColorScheme") var appColorScheme: String = "Indigo"
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
                .scaleEffect(1.5)
                .rotationEffect(.degrees(180))
                .offset(y: backgroundScroll)
                .zIndex(-1)
            
            ScrollView {
                
                scrollDetector
                
                PlatesView()
                
                ForEach(daysToVM.eventsfilterdBySearch()) { event in
                    EventRowView(namespace: namespace, event: event)
                }
                
            }
            .scrollIndicators(.hidden)
            .coordinateSpace(name: "scroll")
            .safeAreaInset(edge: .top, content: { Color.clear.frame(height: 70) })
            .overlay(NavBarView(hasScrolled: $hasScrolled, namespace: namespace, title: "DaysTo"))
            .scaleEffect(daysToVM.showAddEventView || daysToVM.showSettingsView || daysToVM.showEditEventView || !isSignedIn || daysToVM.showMyAccount || daysToVM.showCreditsView ? 0.9 : 1)
            if daysToVM.showAddEventView || daysToVM.showSettingsView || daysToVM.showEditEventView || !isSignedIn {
                Color.clear.background(.ultraThinMaterial)
            }
            
            ForEach(daysToVM.eventsfilterdBySearch()) { event in
                if event == daysToVM.eventToEdit {
                    EditEventView(namespace: namespace,
                                  eventID: event.id,
                                  eventName: event.name,
                                  eventDescription: event.description,
                                  eventDate: event.date,
                                  isFavorite: event.isFavorite,
                                  isRepeated: event.isRepeated)
                }
            }
            
            AddEventView()
                .offset(y: daysToVM.showAddEventView ? 0 : 1000)
            AccountView()
                .offset(y: daysToVM.showMyAccount ? 0 : 1000)
            SettingsView(namespace: namespace)
                .offset(y: daysToVM.showSettingsView ? 0 : 1000)
            CreditsView()
                .offset(y: daysToVM.showCreditsView ? 0 : 1000)
            
            if !isSignedIn {
                AuthentificationView()
            }
        }
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
    }
}

