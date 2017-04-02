//
//  RealmModel.swift
//  RealmPhotoAlbum
//
//  Created by Mijeong Jeon on 31/03/2017.
//  Copyright © 2017 Mijeong Jeon. All rights reserved.
//

import Foundation
import RealmSwift

// Album Model
class Album: Object {
    dynamic var title: String = ""
    // for Realm Migration test(title2 -> subTitle)
//    dynamic var subTitle: String = ""
    dynamic var saveDate: Date = Date()
    // UUID for Primary-key and Migarion test
    dynamic var uuid: String = UUID().uuidString
    let photos: List<Photo> = List<Photo>()
    
    // set primary-key
//    override class func primaryKey() -> String? {
//        return "uuid"
//    }
}


// Photo Model
class Photo: Object {
    dynamic var saveDate: Date = Date()
    dynamic var imageData: Data = Data()
}
