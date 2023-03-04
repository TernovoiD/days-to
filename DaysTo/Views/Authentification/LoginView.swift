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
    @State var error: String = ""
    @State var showResetPasswordView: Bool = false
    @FocusState var selectedField: FocusText?
    
    enum FocusText {
        case email
        case password
    }
    
    var isFormValid: Bool {
        if email.isEmpty || password.isEmpty {
            error = "Fields cannot be empty."
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
            Text("Login", comment: "Login screen title")
                .padding(10)
                .font(.title.weight(.black))
                .glassyFont(textColor: .primary)
            fields
            Button {
                showResetPasswordView = true
            } label: {
                Text("Forgot password?", comment: "Button that leads to reset password screen")
                    .glassyFont(textColor: Color.blue)
                    .font(.callout)
                    .padding(.horizontal)
                    .padding(.top)
            }
            Spacer()
            Text(error)
                .glassyFont(textColor: .red)
                .font(.headline.weight(.bold))
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
            Button {
                signIN()
            } label: {
                Text("Sign In", comment: "Button that leads to sign user in")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            }
            .padding(.top, 20)
        }
        .padding()
        .ignoresSafeArea(.keyboard)
        .background()
        .onTapGesture {
            selectedField = .none
        }
        .sheet(isPresented: $showResetPasswordView) {
            ResetPasswordView(showResetPasswordView: $showResetPasswordView)
        }
        .alert(daysToVM.alertMessage, isPresented: $daysToVM.alert) {
            Button("OK", role: .cancel) { daysToVM.alert = false }
        }
        .onDisappear {
            clearForm()
        }
    }
    
    var fields: some View {
        VStack(alignment: .leading, spacing: 15) {
            TextField("Email", text: $email)
                .padding()
                .selectedField(colors: selectedField == .email ? [.indigo, .blue] : [.clear, .clear])
                .focused($selectedField, equals: .email)
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                .keyboardType(.emailAddress)
                .submitLabel(.next)
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
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
                .keyboardType(.default)
                .submitLabel(.done)
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
                .onSubmit {
                    selectedField = .none
                }
                .onTapGesture {
                    selectedField = .password
                }
        }
    }
    
    func signIN() {
        error = ""
        if isFormValid {
            daysToVM.signIn(userEmail: email, userPassword: password)
            daysToVM.reloadWidget()
            clearForm()
        }
    }
    
    func clearForm() {
        email = ""
        password = ""
        error = ""
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(DaysToViewModel())
    }
}
