//  AppDelegate.swift
//  Simple-Photo-App
//
//  Created by Iyin Raphael on 5/13/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let controller = PhotoController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        controller.fetchPhoto()
        // Override point for customization after application launch.
        return true
    }

}

