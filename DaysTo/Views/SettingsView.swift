//
//  SettingsView.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 05.02.2023.
//

import SwiftUI

struct SettingsView: View {
    var namespace: Namespace.ID
    @EnvironmentObject var daysToVM: DaysToViewModel
    @AppStorage("askBeforeDelete") var askBeforeDelete: Bool = true
    @AppStorage("backgroundScheme") var backgroundScheme: String = "Background Purple Waves"
    @AppStorage("appColorScheme") var appColorScheme: String = "Indigo"
    var body: some View {
        
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 15) {
                topPanel
                    .padding(.bottom)
                toggles
                Divider()
                colors
            }
            .padding()
            .background()
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            .shadow(radius: 5, y: 5)
        .padding()
        }
    }
    
    var topPanel: some View {
        HStack {
            Text("Settings", comment: "Setting screen title")
                .font(.title.weight(.bold))
                .foregroundStyle(.linearGradient(colors: [.primary, .primary.opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing))
            Spacer()
            Button {
                withAnimation(.easeInOut) {
                    daysToVM.showSettingsView = false
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
    
    var toggles: some View {
            Toggle("Ask before delete", isOn: $askBeforeDelete)
            .font(.title3)
    }
    
    var colors: some View {
            HStack {
                Text("Color scheme:", comment: "Choose app color scheme")
                    .font(.title3)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                ForEach(CustomizationModel.colorSchemes) { scheme in
                    Button {
                        backgroundScheme = scheme.backgroundPicture
                        appColorScheme = scheme.name
                    } label: {
                        scheme.color
                            .frame(maxWidth: 30, maxHeight: 30)
                            .clipShape(Circle())
                    }

                }
                Spacer()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        ZStack {
            LinearGradient(colors: [.purple, .white], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            SettingsView(namespace: namespace)
                .environmentObject(DaysToViewModel())
        }
    }
}
