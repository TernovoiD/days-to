//
//  AuthentificationView.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 12.02.2023.
//

import SwiftUI

struct AuthentificationView: View {
    @StateObject var authentificationVM = AuthentificationViewModel()
    @State var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            signIn
                .tag(0)
            signUp
                .tag(1)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
    
    var signIn: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Login")
                .padding(10)
                .font(.title.weight(.black))
                .frame(maxWidth: .infinity)
            TextField("Email", text: $authentificationVM.email)
                .padding()
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            Divider()
            TextField("Password", text: $authentificationVM.password)
                .padding()
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            
            Button {
                authentificationVM.signIn()
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
                    changeTab()
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
    
    var signUp: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Create account")
                .padding(10)
                .font(.title.weight(.black))
                .frame(maxWidth: .infinity)
            TextField("Email", text: $authentificationVM.email)
                .padding()
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            Divider()
            TextField("Password", text: $authentificationVM.password)
                .padding()
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            
            Button {
                authentificationVM.signUp()
            } label: {
                Text("Sign Up")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            }
            .padding(.top, 20)
            
            HStack {
                Text("Already have an account?")
                Button {
                    changeTab()
                } label: {
                    Text("Sign In".uppercased())
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
    
    func changeTab() {
        withAnimation(.easeInOut) {
            selectedTab = selectedTab == 0 ? 1 : 0
        }
    }
}

struct AuthentificationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthentificationView()
            .environmentObject(AuthentificationViewModel())
    }
}
