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
    
    var body: some View {
        ZStack {
            Image(backgroundScheme)
                .resizable()
                .scaleEffect(1.2)
                .background()
                .offset(y: backgroundScroll)
                .zIndex(-1)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        daysToVM.openMenu = false
                        daysToVM.selectedEvent = nil
                    }
                }
            
            if #available(iOS 16.0, *) {
                scrollableContent
                    .scrollIndicators(.hidden)
                    .scrollDismissesKeyboard(.immediately)
            } else {
                scrollableContent
            }
            
            
            if daysToVM.showSettingsView {
                Color.clear.background(.ultraThinMaterial)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            daysToVM.showAddEventView = false
                            daysToVM.showSettingsView = false
                            daysToVM.showEditEventView = false
                            daysToVM.eventToEdit = nil
                        }
                    }
            }
            
            ForEach(daysToVM.events) { event in
                if event == daysToVM.eventToEdit {
                        EditEventView(eventID: event.id,
                                      eventName: event.name,
                                      eventDate: event.date,
                                      eventDescription: "",
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
            AuthentificationView()
                .offset(y: !isSignedIn ? 0 : 1000)
        }
        .ignoresSafeArea(.keyboard)
        .onDisappear {
            daysToVM.reloadWidget()
        }
    }
    
    var scrollableContent: some View {
        ScrollView {
            
            scrollDetector

            PlatesView()
            
            clearFiltersButton
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal)
                .offset(x: daysToVM.showFavoriteOnly || daysToVM.sevenDays ? 0 : 1000)

            ForEach(daysToVM.eventsfilterdBySearch()) { event in
                EventRowView(namespace: namespace, event: event)
            }
            
        }
        .coordinateSpace(name: "scroll")
        .safeAreaInset(edge: .top, content: { Color.clear.frame(height: 70) })
        .overlay(NavBarView(hasScrolled: $hasScrolled, namespace: namespace, title: "DaysTo"))
        .scaleEffect(daysToVM.showAddEventView || daysToVM.showSettingsView || daysToVM.showEditEventView || !isSignedIn || daysToVM.showMyAccount || daysToVM.showCreditsView ? 0.8 : 1)
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
    
    var clearFiltersButton: some View {
        Button {
            withAnimation(.easeInOut) {
                daysToVM.showFavoriteOnly = false
                daysToVM.sevenDays = false
            }
        } label: {
            HStack {
                Text("Clear all filters", comment: "Button that leads to clear all search filters")
                Image(systemName: "xmark")
            }
            .padding(5)
            .padding(.horizontal, 10)
            .font(.headline)
            .glassyFont(textColor: .white)
            .background(Color(appColorScheme))
            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
        }
        
    }
    
    func calculateBackgroundScroll(_ proxy: CGFloat) -> CGFloat {
        if proxy >= 0 {
            return 0
        } else if proxy < -200 {
            return -200 * 1.3
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

