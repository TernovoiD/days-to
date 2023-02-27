//
//  AuthentificationView.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 25.02.2023.
//

import SwiftUI

struct AuthentificationView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                InstrucrtionsView()
                Spacer()
                VStack {
                    NavigationLink(destination: LoginView()) {
                        HStack {
                            Text("Sign In")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .padding()
                        .background(Color.gray.opacity(0.15))
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    }
                    NavigationLink(destination: RegistrationView()) {
                        HStack {
                            Text("Create new account")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .padding()
                        .background(Color.gray.opacity(0.15))
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    }
                }
                .padding(.horizontal)
                Spacer()
                VStack(alignment: .leading, spacing: 5) {
                    Text("Why do I need personal account?")
                        .glassyFont(textColor: .primary)
                        .fontWeight(.bold)
                    Text("- It makes your data safe.")
                    Text("- It will grant You access from different devices.")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .glassyFont(textColor: .secondary)
                .padding(.horizontal)
            }
        }
    }
}

struct AuthentificationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthentificationView()
            .environmentObject(DaysToViewModel())
    }
}
