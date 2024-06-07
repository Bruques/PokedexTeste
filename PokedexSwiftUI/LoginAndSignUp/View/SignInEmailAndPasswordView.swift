//
//  SignInEmailAndPasswordView.swift
//  PokedexSwiftUI
//
//  Created by Bruno Marques on 01/06/24.
//

import SwiftUI

struct SignInEmailAndPasswordView: View {
    @EnvironmentObject var userSession: UserSession
    @ObservedObject var vm = SignInViewModel()
    @FocusState var isFocused: Bool
    var body: some View {
        VStack {
            titleAndDescription
            Spacer().frame(height: 24)
            emailField
            Spacer().frame(height: 16)
            passwordField
            Spacer().frame(height: 32)
            forgotPasswordButton
            Spacer()
            continueButton
        }
        .padding()
        .navigationBarBackButtonHidden()
        .modifier(MyCustomToolbar(title: "Criar conta"))
        .onReceive(vm.userCreated) { user in
            self.userSession.setUser(user)
        }
        .overlay {
            if vm.viewState == .loading {
                LoadingView()
            }
        }
    }
    
    var titleAndDescription: some View {
        VStack {
            Text("Bem vindo de volta!")
                .font(FontMaker.makeFont(.poppinsRegular, 26))
                .foregroundStyle(PokedexColors.gray700)
            Text("Preencha seus dados")
                .font(FontMaker.makeFont(.poppinsSemiBold, 26))
        }
    }
    
    var emailField: some View {
        VStack {
            Text("E-mail")
                .font(FontMaker.makeFont(.poppinsMedium, 14))
                .foregroundStyle(PokedexColors.gray700)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField("E-mail", text: $vm.email, onEditingChanged: { editingChanged in
                self.vm.emailFocused = editingChanged
            })
            .keyboardType(.emailAddress)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .textContentType(.emailAddress)
            .font(FontMaker.makeFont(.poppinsRegular, 16))
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(lineWidth: 2)
                    .foregroundStyle(vm.emailFocused ? PokedexColors.primary : PokedexColors.lightGray)
                    .frame(height: 52)
            }
        }
    }
    
    var passwordField: some View {
        VStack {
            Text("Senha")
                .font(FontMaker.makeFont(.poppinsMedium, 14))
                .foregroundStyle(PokedexColors.gray700)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Group {
                if vm.isSecureField {
                    SecureField("Senha", text: $vm.password)
                } else {
                    TextField("Senha", text: $vm.password)
                }
            }
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .focused($isFocused)
            .font(FontMaker.makeFont(.poppinsRegular, 16))
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(lineWidth: 2)
                    .foregroundStyle(isFocused ? PokedexColors.primary : PokedexColors.lightGray)
                    .frame(height: 52)
            }
            .overlay(alignment: .trailing) {
                Image(systemName: vm.isSecureField ? "eye.slash" : "eye")
                    .padding()
                    .onTapGesture {
                        vm.isSecureField.toggle()
                    }
            }
        }
    }
    
    var forgotPasswordButton: some View {
        Text("Esqueceu sua senha?")
            .font(FontMaker.makeFont(.poppinsMedium, 14))
            .foregroundStyle(PokedexColors.blue)
    }
    
    var continueButton: some View {
        Button {
            Task {
                try await vm.login()
            }
        } label: {
            Capsule()
                .frame(height: 58)
                .foregroundStyle(vm.isEmailValid ? PokedexColors.blue : PokedexColors.gray100)
                .overlay {
                    Text("Continuar")
                        .font(FontMaker.makeFont(.poppinsSemiBold, 18))
                        .foregroundStyle(vm.isEmailValid ? .white : PokedexColors.secondary)
                }
                
        }
        .disabled(vm.email.isEmpty ? true : false)
    }
}

#Preview {
    SignInEmailAndPasswordView()
}
