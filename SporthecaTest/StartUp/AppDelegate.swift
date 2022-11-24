//
//  AppDelegate.swift
//  SporthecaTest
//
//  Created by Patricia Cintia de Souza on 23/11/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = HomeViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
}
