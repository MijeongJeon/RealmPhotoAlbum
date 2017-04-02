//
//  AppDelegate.swift
//  RealmPhotoAlbum
//
//  Created by Mijeong Jeon on 31/03/2017.
//  Copyright © 2017 Mijeong Jeon. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    /* schemaVerion 0
     dynamic var title: String = ""
     dynamic var saveDate: Date = Date()
     let photos: List<Photo> = List<Photo>()
     */
    
    /* schemaVerion 1
     dynamic var title: String = ""
     dynamic var saveDate: Date = Date()
     // add uuid
     dynamic var uuid: String = UUID().uuidString
     let photos: List<Photo> = List<Photo>()
     */
    
    /* schemaVerion 2
     dynamic var title: String = ""
     // add subTitle
     dynamci var title2: String = ""
     dynamic var saveDate: Date = Date()
     // add uuid
     dynamic var uuid: String = UUID().uuidString
     let photos: List<Photo> = List<Photo>()
     */
    
    /* schemaVerion 3
     dynamic var title: String = ""
     // change property name
     dynamci var subTitle: String = ""
     dynamic var saveDate: Date = Date()
     // add uuid
     dynamic var uuid: String = UUID().uuidString
     let photos: List<Photo> = List<Photo>()
     */
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // Realm Migration
        let migrationBlock: MigrationBlock = { migration, oldSchemaVersion in
            migration.enumerateObjects(ofType: Album.className(), { (oldObject, newObject) in
                if oldSchemaVersion < 1 {
                    // set default value of new property
                    newObject?["uuid"] = UUID().uuidString
                }
                if oldSchemaVersion < 2 {
                    // set default value of new property
                    newObject?["subTitle"] = oldObject?["title"]
                }
            })
//            // rename outside of enumeratObeject
            if oldSchemaVersion == 2 {
                migration.renameProperty(onType: Album.className(), from: "title2", to: "subTitle")
            }
            print("Migration complete.")
        }
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 3, migrationBlock: migrationBlock)
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

