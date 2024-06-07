//
//  PokedexSwiftUIApp.swift
//  PokedexSwiftUI
//
//  Created by Bruno Marques on 27/01/24.
//

import SwiftUI
import FirebaseCore

@main
struct PokedexSwiftUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var userSession = UserSession()
    var body: some Scene {
        WindowGroup {
//            if let user = userSession.user {
//                // Home
//                PokemonListView()
//            } else {
//                OnboardingView()
//                    .environmentObject(userSession)
//            }
            PokemonListView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
