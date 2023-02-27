//
//  PasswordChangeView.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 26.02.2023.
//

import SwiftUI

struct PasswordChangeView: View {
    @EnvironmentObject var daysToVM: DaysToViewModel
    @State var newPassword: String = ""
    @State var repeatPassword: String = ""
    @State var error: String = ""
    @FocusState var selectedField: FocusText?
    
    enum FocusText {
        case newPassword
        case repeatPassword
    }
    
    var isFormValid: Bool {
        if repeatPassword.isEmpty || newPassword.isEmpty {
            error = "Fields cannot be empty."
            return false
        }  else if newPassword != repeatPassword {
            error = "Passwords don't match."
            return false
        } else {
            return true
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Spacer()
            Text("Change password")
                .padding(10)
                .font(.title.weight(.black))
                .glassyFont(textColor: .primary)
                .frame(maxWidth: .infinity)
            VStack(alignment: .leading, spacing: 15) {
                TextField("New password", text: $newPassword)
                    .padding()
                    .selectedField(colors: selectedField == .newPassword ? [.indigo, .blue] : [.clear, .clear])
                    .focused($selectedField, equals: .newPassword)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                    .submitLabel(.next)
                    .onSubmit {
                        selectedField = .repeatPassword
                    }
                Divider()
                SecureField("Repeat new password", text: $repeatPassword)
                    .padding()
                    .selectedField(colors: selectedField == .repeatPassword ? [.indigo, .blue] : [.clear, .clear])
                    .focused($selectedField, equals: .repeatPassword)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    .keyboardType(.default)
                    .autocorrectionDisabled(true)
                    .submitLabel(.done)
                    .textInputAutocapitalization(.never)
                    .onSubmit {
                        selectedField = .none
                    }
            }
            Spacer()
            Text(error)
                .glassyFont(textColor: .red)
                .fontWeight(.bold)
                .padding(.horizontal)
            Button {
                changePassword()
            } label: {
                Text("Change")
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
        .alert(daysToVM.alertMessage, isPresented: $daysToVM.alert) {
            Button("OK", role: .cancel) { daysToVM.alert = false }
        }
        .onDisappear {
            clearForm()
        }
    }
    
    func changePassword() {
        error = ""
        if isFormValid {
            daysToVM.updatePassword(password: newPassword)
        }
    }
    
    func clearForm() {
        repeatPassword = ""
        newPassword = ""
        error = ""
    }
}

struct PasswordChangeView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordChangeView()
            .environmentObject(DaysToViewModel())
    }
}
