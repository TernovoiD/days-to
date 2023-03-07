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
            ZStack {
                ScrollView {
                    VStack(spacing: 20) {
                        Image(systemName: "person")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .glassyFont(textColor: Color(appColorScheme))
                        VStack(spacing: 10) {
                            VStack(alignment: .leading, spacing: 5) {
                                HStack {
                                    Text(daysToVM.userInfo?.name ?? "username")
                                        .font(.title2.weight(.black))
                                        .glassyFont(textColor: .primary)
                                    Spacer()
                                    Text(daysToVM.userInfo?.dateOfBirth.simpleDate(formatStyle: "dd MMM Y") ?? "Date of Birth")
                                }
                                Text(daysToVM.userInfo?.email ?? "useremail")
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
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
                }
                .padding(.horizontal)
                .safeAreaInset(edge: .top) {
                    Color.clear.frame(maxHeight: 60)
                }
                
                VStack {
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
                    Spacer()
                }
                .padding()
            }
            .onDisappear {
                resetPassword = false
                verifyEmail = false
            }
            .alert("This will delete your account", isPresented: $showDeleteConfirmationAlert) {
                Button("DELETE", role: .destructive) {
                    withAnimation(.easeInOut) {
                        daysToVM.deleteUser()
                        daysToVM.signOut()
                        daysToVM.reloadWidget()
                        daysToVM.showMyAccount = false
                    }
                }
            }
            .alert(daysToVM.alertMessage, isPresented: $daysToVM.alert) {
                Button("OK", role: .cancel) { daysToVM.alert = false }
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
