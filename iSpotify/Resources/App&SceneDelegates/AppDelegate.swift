//
//  AppDelegate.swift
//  iSpotify
//
//  Created by Ahmet Tarik DÖNER on 9.02.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = TabBarViewController()
        window.makeKeyAndVisible()
        self.window = window
        return true
    }

}

