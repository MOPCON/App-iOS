//
//  AppDelegate.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/1.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit
import CoreData

import Firebase
import FirebaseDynamicLinks
import FirebaseMessaging
import UserNotifications
import SafariServices

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        updateNavigationBarStyle()
        
        FirebaseApp.configure()
        
        Messaging.messaging().delegate = self
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        //Init FavoriteManager
        _ = FavoriteManager.shared
        
        return true
    }
    
    private func updateNavigationBarStyle() {
        
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        
        UINavigationBar.appearance().shadowImage = UIImage.imageWithColor(color: (UIColor.navigationBottomBorderColor?.withAlphaComponent(0.2))!)
        
        UINavigationBar.appearance().tintColor = .white
        
        UINavigationBar.appearance().isTranslucent = true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        print(userInfo)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNs token retrieved: \(deviceToken)")
        Messaging.messaging().apnsToken = deviceToken
        
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        if let dynamicLink = DynamicLinks.dynamicLinks().dynamicLink(fromCustomSchemeURL: url) {
            
            guard let link = dynamicLink.url, let sn = link.queryParameters?["sn"] else { return true }
            
            let uuid = KeychainTool.retrive(for: "uuid") ?? UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
            
            invite(with: uuid, and: sn)
            
            return true
        }
        
        return false
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        // Handle url if app has installed
        
        let handled = DynamicLinks.dynamicLinks().handleUniversalLink(userActivity.webpageURL!) { [weak self] (dynamiclink, error) in
            
            print("app has installed \(String(describing: dynamiclink?.url))")
            
            guard let link = dynamiclink?.url, let sn = link.queryParameters?["sn"] else { return }
            
            let uuid = KeychainTool.retrive(for: "uuid") ?? UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
            
            self?.invite(with: uuid, and: sn)
        }

        return handled
    }
    
    private func invite(with uid: String, and email: String) {
        
        FieldGameProvider.invite(with: uid, and: email)
    }
}

@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo

        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        print(userInfo)
        completionHandler([])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }        
        print(userInfo)
        completionHandler()
    }
}

extension AppDelegate : MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        
        let dataDict:[String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
}

