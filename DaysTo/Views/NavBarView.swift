//
//  NavBarView.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 05.02.2023.
//

import SwiftUI

struct NavBarView: View {
    @EnvironmentObject var daysToVM: DaysToViewModel
    @Binding var hasScrolled: Bool
//    @State var openMenu: Bool = false
    var namespace: Namespace.ID
    var title: String = "Navigation"
    
    var body: some View {
        HStack(alignment: .top) {
            Text(title)
                .font(hasScrolled ? .title3.bold() : .largeTitle.weight(.bold))
                .padding(hasScrolled ? 7 : 0)
                .background(.ultraThinMaterial.opacity(hasScrolled ? 1 : 0))
                .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        daysToVM.openMenu = false
                        daysToVM.selectedEvent = nil
                    }
                }
            Spacer()
            menu
        }
        .padding(.horizontal)
        .foregroundColor(.white)
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.top, hasScrolled ? 0 : 25)
    }
    
    var menu: some View {
        ZStack {
            Image(systemName: "circle.grid.3x3.fill").opacity(0)
                .padding(hasScrolled ? 7 : 0)
            VStack(alignment: .leading, spacing: 10) {
                Button {
                    withAnimation(.easeInOut) {
                        daysToVM.openMenu.toggle()
//                        daysToVM.selectedEvent = nil
                    }
                } label: {
                    if daysToVM.openMenu {
                        Label("Close", systemImage: "xmark")
                    } else {
                        Image(systemName: "text.justify")
                    }
                }
                if daysToVM.openMenu {
                    Divider()
                        .frame(maxWidth: 100)
                    Button {
                        withAnimation(.easeInOut) {
                            daysToVM.openMenu = false
                            daysToVM.showAddEventView = true
                        }
                    } label: {
                        HStack {
                            Image(systemName: "plus")
                                .frame(maxWidth: 20)
                            Text("Add Event")
                        }
                    }
                    Button {
                        withAnimation(.easeInOut) {
                            daysToVM.openMenu = false
                            daysToVM.showMyAccount = true
                        }
                    } label: {
                        HStack {
                            Image(systemName: "person")
                                .frame(maxWidth: 20)
                            Text("My account")
                        }
                    }
                    Button {
                        withAnimation(.easeInOut) {
                            daysToVM.openMenu = false
                            daysToVM.showSettingsView = true
                        }
                    } label: {
                        HStack {
                            Image(systemName: "gear")
                                .frame(maxWidth: 20)
                            Text("Settings")
                        }
                    }
                    Button {
                        withAnimation(.easeInOut) {
                            daysToVM.openMenu = false
                            daysToVM.showCreditsView = true
                        }
                    } label: {
                        HStack {
                            Image(systemName: "c.circle")
                                .frame(maxWidth: 20)
                            Text("Credits")
                        }
                    }
//                    Button {
//                        withAnimation(.easeInOut) {
//                            daysToVM.openMenu = false
//                            daysToVM.reloadWidget()
//                        }
//                    } label: {
//                        HStack {
//                            Image(systemName: "goforward")
//                                .frame(maxWidth: 20)
//                            Text("Reload Widget")
//                        }
//                    }
                    Divider()
                        .frame(maxWidth: 100)
                    Button {
                        withAnimation(.easeInOut) {
                            daysToVM.openMenu = false
                            daysToVM.signOut()
                            daysToVM.reloadWidget()
                        }
                    } label: {
                        HStack {
                            Image(systemName: "person.fill.xmark")
                                .frame(maxWidth: 20)
                            Text("Sign Out")
                        }
                    }
                }
            }
            .font(.headline)
        }
        .font(hasScrolled ? .title3.bold() : .largeTitle.weight(.bold))
        .padding(daysToVM.openMenu ? 15 : 0)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
    
    func toggleMenu() {
        withAnimation(.easeInOut) {
            daysToVM.openMenu.toggle()
        }
    }
}

struct NavBarView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        NavBarView(hasScrolled: .constant(true), namespace: namespace)
            .environmentObject(DaysToViewModel())
            .background(
                LinearGradient(colors: [.indigo, .purple], startPoint: .top, endPoint: .bottom)
            )
    }
}
