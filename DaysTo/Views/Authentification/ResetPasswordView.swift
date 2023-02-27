//
//  ResetPasswordView.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 25.02.2023.
//

import SwiftUI

struct ResetPasswordView: View {
    @EnvironmentObject var daysToVM: DaysToViewModel
    @State var email: String = ""
    @State var error: String = ""
    @Binding var showResetPasswordView: Bool
    @FocusState var selectedField: FocusText?
    
    enum FocusText {
        case email
    }
    
    var isFormValid: Bool {
        if email.isEmpty {
            error = "Field cannot be empty."
            return false
        } else if !email.isValidEmail {
            error = "Email is not valid."
            return false
        } else {
            return true
        }
    }
    
    var body: some View {
        VStack(spacing: 15) {
            Button {
                showResetPasswordView = false
            } label: {
                Image(systemName: "xmark")
                    .padding()
                    .glassyFont(textColor: .primary)
                    .bold()
                    .background(Color.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            Spacer()
            Text("Reset password")
                .padding(10)
                .font(.title.weight(.black))
                .glassyFont(textColor: .primary)
                .frame(maxWidth: .infinity)
            Text("Instructions will be sent on your email")
                .frame(maxWidth: .infinity, alignment: .leading)
                .glassyFont(textColor: .secondary)
                .padding(.horizontal)
            TextField("Email", text: $email)
                .padding()
                .background(Color.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                .keyboardType(.emailAddress)
                .submitLabel(.done)
                .autocorrectionDisabled(true)
                .focused($selectedField, equals: .email)
                .onSubmit {
                    selectedField = .none
                }
            Spacer()
            Text(error)
                .glassyFont(textColor: .red)
                .fontWeight(.bold)
                .padding(.horizontal)
            Button {
                sendPasswordReset()
            } label: {
                Text("Reset")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            }
            .padding(.top, 20)
        }
        .background()
        .onTapGesture {
            selectedField = .none
        }
        .onDisappear {
            email = ""
        }
        .alert(daysToVM.alertMessage, isPresented: $daysToVM.alert) {
            Button("OK", role: .cancel) { daysToVM.alert = false }
        }
        .padding()
        .ignoresSafeArea(.keyboard)
    }
    
    func sendPasswordReset() {
        if isFormValid {
            daysToVM.resetPassword(email: email)
            showResetPasswordView = false
        }
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView(showResetPasswordView: .constant(true))
            .environmentObject(DaysToViewModel())
    }
}
