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
        ZStack {
            ScrollView {
                VStack {
                    Image("daysTo.logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    VStack(alignment: .leading, spacing: 10) {
                        Text("**DaysTo** is a non-commercial program built as a training project to make our everyday life easier. The application was created using Swift programing language on MVVM architectural pattern with frameworks:", comment: "DaysTo credits")
                            .glassyFont(textColor: .primary)
                            .font(.subheadline)
                        VStack(alignment: .leading, spacing: 10) {
                            Text("- SwiftUI by Apple")
                            Text("- WidgetKIT by Apple")
                            Text("- Firebase Auth by Google")
                            Text("- Firestore by Google")
                        }
                        .font(.headline)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                }
            }
            VStack {
                topPanel
                Spacer()
                VStack(spacing: 2) {
                    Text("DaysTo")
                    Text("Version 1.0")
                    Text("Created by Danylo Ternovoi")
                        .font(.headline)
                }
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            }
            .padding(.horizontal)
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
