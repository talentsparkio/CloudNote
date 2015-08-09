//
//  AppDelegate.swift
//  CloudNote
//
//  Created by Nick Chen on 8/8/15.
//  Copyright © 2015 TalentSpark. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // TODO: You need to enter your own appId and clientKey
        Parse.setApplicationId("DnAVErSXLQs1XHiPjm5tafWHstTF31YpPd8MaTAK", clientKey: "QCRGgMt573gTUKHUODBpMaUXenvpzVUZsCNSoZLK")
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
    }

    func applicationWillEnterForeground(application: UIApplication) {
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
    }

}

