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
            VStack(alignment: .leading) {
                Spacer()
                InstrucrtionsView()
                Spacer()
                VStack {
                    NavigationLink(destination: LoginView()) {
                        HStack {
                            Text("Sign In", comment: "This button leads to Login screen")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .padding()
                        .background(Color.gray.opacity(0.15))
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    }
                    NavigationLink(destination: RegistrationView()) {
                        HStack {
                            Text("Create new account", comment: "This button leads to Registration screen")
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
                    Text("Why do I need personal account?", comment: "Desciption of creation account purposes")
                        .font(.headline.weight(.bold))
                        .glassyFont(textColor: .primary)
                    Text("- It makes your data safe.", comment: "Point 1 to create account")
                    Text("- It will grant You access from different devices.", comment: "Point 2 to create account")
                }
                .glassyFont(textColor: .secondary)
                .padding()
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
