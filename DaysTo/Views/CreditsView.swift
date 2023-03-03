//
//  CreditsView.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 27.02.2023.
//

import SwiftUI

struct CreditsView: View {
    @EnvironmentObject var daysToVM: DaysToViewModel
    var body: some View {
        VStack {
            topPanel
                .padding(.horizontal)
            Image("daysTo.logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
            VStack(alignment: .leading, spacing: 10) {
                Text("**DaysTo** is a non-commercial program built as a training project to make our everyday life easier. The application was created using Swift programing language on MVVM architectural pattern with frameworks:")
                    .glassyFont(textColor: .primary)
                Text("- SwiftUI by Apple")
                    .font(.headline)
                Text("- WidgetKIT by Apple")
                    .font(.headline)
                Text("- Firebase Auth by Google")
                    .font(.headline)
                Text("- Firestore by Google")
                    .font(.headline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
            Spacer()
            VStack(spacing: 2) {
                Text("DaysTo")
                Text("Version 0.1.1")
                Text("Created by Danylo Ternovoi")
                    .font(.headline)
            }
            .padding(.top, 80)
        }
        .background()
    }
    
    
    var topPanel: some View {
        HStack {
                Spacer()
                Button {
                    withAnimation(.easeInOut) {
                        daysToVM.showCreditsView = false
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
        .foregroundColor(.white)
    }
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView()
            .environmentObject(DaysToViewModel())
    }
}
