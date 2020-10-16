//
//  AppDelegate.swift
//  RentACar
//
//  Created by Denislava Stoyanova on 2.09.20.
//  Copyright © 2020 Denislava Stoyanova. All rights reserved.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        window = UIWindow(frame: UIScreen.main.bounds)

        appCoordinator = AppCoordinator()
        window?.rootViewController = appCoordinator.start()
        window?.makeKeyAndVisible()
        return true
    }
}

