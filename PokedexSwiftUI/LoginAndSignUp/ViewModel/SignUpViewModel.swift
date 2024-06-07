//
//  SignUpViewModel.swift
//  PokedexSwiftUI
//
//  Created by Bruno Marques on 06/02/24.
//

import Foundation
import Combine
import FirebaseAuth

class SignUpViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var isEmailValid: Bool = false
    @Published var emailFocused: Bool = false
    @Published var password: String = ""
    @Published var isPasswordValid: Bool = false
    @Published var isSecureField: Bool = true
    @Published var username: String = ""
    @Published var isUsername: Bool = false
    @Published var isUsernameValid: Bool = false
    var userCreated = PassthroughSubject<User, Never>()
    var cancellables = Set<AnyCancellable>()
    
    init() {
        setupBindings()
    }
    
    private func setupBindings() {
        $email
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { email in
            self.isEmailValid = self.validateEmail(enteredEmail: email)
        }.store(in: &cancellables)
        
        $password.sink { password in
            self.isPasswordValid = password.count >= 6
        }.store(in: &cancellables)
        
        $username.sink { username in
            if !username.isEmpty {
                self.isUsernameValid = true
            } else {
                self.isUsername = false
            }
        }.store(in: &cancellables)
    }
    
    private func validateEmail(enteredEmail: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
    }
    
    func registerUser() async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: self.email, password: self.password)
            await didCreateUser()
        } catch {
            print("$$$\(error.localizedDescription)")
        }
    }
    
    @MainActor
    private func didCreateUser() {
        let user = User(email: self.email, userName: self.username)
        userCreated.send(user)
    }
}
