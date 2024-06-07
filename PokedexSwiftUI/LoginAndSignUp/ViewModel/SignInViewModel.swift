//
//  SignInViewModel.swift
//  PokedexSwiftUI
//
//  Created by Bruno Marques on 01/06/24.
//

import Foundation
import Combine
import FirebaseAuth

class SignInViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var isEmailValid: Bool = false
    @Published var emailFocused: Bool = false
    @Published var password: String = ""
    @Published var isPasswordValid: Bool = false
    @Published var isSecureField: Bool = true
    @Published var viewState: SimpleLoadState = .idle(success: true)
    
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
    }
    
    private func validateEmail(enteredEmail: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
    }
    
    public func loginValidation() -> Bool {
        return isEmailValid && isPasswordValid
    }
    
    func login() async throws {
        do {
            viewState = .loading
            _ = try await Auth.auth().signIn(withEmail: email, password: password)
//            viewState = .idle(success: true)
            await self.didCreateUser()
        } catch {
//            viewState = .idle(success: false)
        }
    }
    
    @MainActor
    private func didCreateUser() {
        let user = User(email: self.email, userName: "Teste")
        userCreated.send(user)
    }
}
