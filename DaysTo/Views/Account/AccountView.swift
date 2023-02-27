//
//  AccountView.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 26.02.2023.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var daysToVM: DaysToViewModel
    @AppStorage("appColorScheme") var appColorScheme: String = "Indigo"
    @State var resetPassword: Bool = false
    @State var verifyEmail: Bool = false
    @State var showDeleteConfirmationAlert: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Button {
                        withAnimation(.easeInOut) {
                            daysToVM.showMyAccount = false
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title3.weight(.black))
                            .padding(10)
                            .foregroundColor(.primary)
                            .background(.thinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    Image(systemName: "person.crop.square.filled.and.at.rectangle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .glassyFont(textColor: Color(appColorScheme))
                    VStack(spacing: 10) {
                        Text(daysToVM.userInfo?.name ?? "username")
                            .font(.title2.weight(.black))
                            .glassyFont(textColor: .primary)
                        NavigationLink(destination: PasswordChangeView()) {
                            HStack {
                                Label("Change password", systemImage: "lock.open.rotation")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .padding()
                            .background(Color.gray.opacity(0.15))
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                        }
                        Button {
                            sendVerificationEmail()
                        } label: {
                            HStack {
                                Label("Send verification email", systemImage: "checkmark.seal")
                                Spacer()
                            }
                            .padding()
                            .background(Color.gray.opacity(0.15))
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                        }
                        if verifyEmail {
                            Text("Verification email was sent to: \(daysToVM.userInfo?.email ?? "error")")
                                .font(.caption)
                                .foregroundColor(.green)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                        }
                        Button {
                            showDeleteConfirmationAlert = true
                        } label: {
                            HStack {
                                Label("Delete account", systemImage: "trash")
                                Spacer()
                            }
                            .padding()
                            .foregroundColor(.red)
                            .background(Color.gray.opacity(0.15))
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                        }
                    }
                }
                .padding(.horizontal)
                .onDisappear {
                    resetPassword = false
                    verifyEmail = false
                }
                .alert("This will delete your account", isPresented: $showDeleteConfirmationAlert) {
                    Button("DELETE", role: .destructive) {
                        withAnimation(.easeInOut) {
                            daysToVM.deleteUser()
                        }
                    }
                }
            }
        }
    }
    
    func sendVerificationEmail() {
        daysToVM.sendEmailVerification()
        if !daysToVM.alert {
            verifyEmail = true
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
            .environmentObject(DaysToViewModel())
    }
}
