//
//  LoginView.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 14.02.2023.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var daysToVM: DaysToViewModel
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Login")
                .padding(10)
                .font(.title.weight(.black))
                .frame(maxWidth: .infinity)
            TextField("Email", text: $email)
                .padding()
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            Divider()
            TextField("Password", text: $password)
                .padding()
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            
            Button {
                daysToVM.signIn(userEmail: email, userPassword: password)
            } label: {
                Text("Sign In")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            }
            .padding(.top, 20)
            
            HStack {
                Text("Don't have an account?")
                Button {
                    withAnimation(.easeInOut) {
                        daysToVM.showCreateAccountView = true
                    }
                } label: {
                    Text("Sign up".uppercased())
                        .bold()
                }
            }
            .frame(maxWidth: .infinity)
            
        }
        .padding()
        .background()
        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
        .shadow(radius: 5, y: 5)
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(DaysToViewModel())
    }
}
