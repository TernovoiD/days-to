//
//  RegistrationView.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 14.02.2023.
//

import SwiftUI

struct RegistrationView: View {
    @EnvironmentObject var daysToVM: DaysToViewModel
    @State var name: String = ""
    @State var dateOfBirth: Date = Date()
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Create an account")
                .padding(10)
                .font(.title.weight(.black))
                .frame(maxWidth: .infinity)
            TextField("Name", text: $name)
                .padding()
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            Divider()
            TextField("Email", text: $email)
                .padding()
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            Divider()
            TextField("Password", text: $password)
                .padding()
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            Divider()
            DatePicker("Date of birth", selection: $dateOfBirth, displayedComponents: .date)
                .datePickerStyle(.compact)
                .padding()
            Button {
                daysToVM.signUp(userName: name, userEmail: email, userDateOfBirth: dateOfBirth, userPassword: password)
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
                    withAnimation(.easeInOut) {
                        daysToVM.showCreateAccountView = false
                    }
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
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
            .environmentObject(DaysToViewModel())
    }
}
