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
    @State var error: String = ""
    @FocusState var selectedField: FocusText?
    
    enum FocusText {
        case name
        case email
        case password
    }
    
    var isFormValid: Bool {
        if email.isEmpty || password.isEmpty || name.isEmpty {
            error = "Fields cannot be empty."
            return false
        } else if !name.isValidName {
            error = "Name must contain at least 3 characters."
            return false
        } else if !email.isValidEmail {
            error = "Email is not valid."
            return false
        } else if !password.isValidPassword {
            error = "Password must contain at least 6 characters."
            return false
        } else {
            return true
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text("Create an account", comment: "Registration screen main titile")
                .padding(10)
                .font(.title.weight(.black))
                .glassyFont(textColor: .primary)
                .frame(maxWidth: .infinity)
            VStack(alignment: .leading, spacing: 10) {
                TextField("Name", text: $name)
                    .padding()
                    .selectedField(colors: selectedField == .name ? [.indigo, .blue] : [.clear, .clear])
                    .focused($selectedField, equals: .name)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    .keyboardType(.default)
                    .autocorrectionDisabled(true)
                    .submitLabel(.next)
                    .onSubmit {
                        selectedField = .email
                    }
                    .onTapGesture {
                        selectedField = .name
                    }
                Divider()
                TextField("Email", text: $email)
                    .padding()
                    .selectedField(colors: selectedField == .email ? [.indigo, .blue] : [.clear, .clear])
                    .focused($selectedField, equals: .email)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                    .submitLabel(.next)
                    .onSubmit {
                        selectedField = .password
                    }
                    .onTapGesture {
                        selectedField = .email
                    }
                Divider()
                SecureField("Password", text: $password)
                    .padding()
                    .selectedField(colors: selectedField == .password ? [.indigo, .blue] : [.clear, .clear])
                    .focused($selectedField, equals: .password)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                    .submitLabel(.done)
                    .onSubmit {
                        selectedField = .none
                    }
                    .onTapGesture {
                        selectedField = .password
                    }
            }
            DatePicker("Date of birth", selection: $dateOfBirth, displayedComponents: .date)
                .datePickerStyle(.compact)
                .padding()
                .background()
            Spacer()
            Text(error)
                .glassyFont(textColor: .red)
                .font(.headline.weight(.bold))
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
            Button {
                signUP()
            } label: {
                Text("Sign Up", comment: "Button that leads to create new account")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            }
            .padding(.top, 20)
        }
        .padding()
        .background()
        .onTapGesture {
            selectedField = .none
        }
        .ignoresSafeArea(.keyboard)
        .alert(daysToVM.alertMessage, isPresented: $daysToVM.alert) {
            Button("OK", role: .cancel) { daysToVM.alert = false }
        }
        .onDisappear {
            clearForm()
        }
    }
    
    func signUP() {
        if isFormValid {
            daysToVM.signUp(userName: name, userEmail: email, userDateOfBirth: dateOfBirth, userPassword: password)
            daysToVM.reloadWidget()
            clearForm()
        }
    }
    
    func clearForm() {
        name = ""
        email = ""
        password = ""
        error = ""
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
            .environmentObject(DaysToViewModel())
    }
}
