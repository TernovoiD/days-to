//
//  NavBarView.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 05.02.2023.
//

import SwiftUI

struct NavBarView: View {
    var namespace: Namespace.ID
    var title: String = "Navigation Bar"
    @EnvironmentObject var daysToVM: DaysToViewModel
    @Binding var hasScrolled: Bool
    @State var openMenu: Bool = false
    
    var body: some View {
        HStack(alignment: .top) {
            Text(title)
                .font(hasScrolled ? .title3.bold() : .largeTitle.weight(.bold))
                .padding(hasScrolled ? 7 : 0)
                .background(.ultraThinMaterial.opacity(hasScrolled ? 1 : 0))
                .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
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
                        openMenu.toggle()
                    }
                } label: {
                    if openMenu {
                        Label("Close", systemImage: "xmark")
                    } else {
                        Image(systemName: "text.justify")
                    }
                }
                if openMenu {
                    RoundedRectangle(cornerRadius: 1, style: .continuous)
                        .frame(maxWidth: 70, maxHeight: 1)
                        .opacity(0.5)
                    Button {
                        withAnimation(.easeInOut) {
                            openMenu = false
                            daysToVM.showAddEventView = true
                        }
                    } label: {
                        Label("Add Event", systemImage: "plus")
                    }
                    Button {
                        withAnimation(.easeInOut) {
                            openMenu = false
                            daysToVM.showSettingsView = true
                        }
                    } label: {
                        Label("Settings", systemImage: "gear")
                    }
                }
            }
            .font(.headline)
        }
        .font(hasScrolled ? .title3.bold() : .largeTitle.weight(.bold))
        .padding(openMenu ? 15 : 0)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
    
    func toggleMenu() {
        withAnimation(.easeInOut) {
            openMenu.toggle()
        }
    }
}

struct NavBarView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        NavBarView(namespace: namespace, hasScrolled: .constant(true))
            .environmentObject(DaysToViewModel())
            .background(
                LinearGradient(colors: [.indigo, .purple], startPoint: .top, endPoint: .bottom)
            )
    }
}
