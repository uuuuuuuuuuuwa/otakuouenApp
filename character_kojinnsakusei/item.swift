import Foundation
import RealmSwift
import SwiftUI


class Item: Object {
    @objc dynamic var apitype: String = ""
    @objc dynamic var id: String = ""
    @objc dynamic var name:String = ""
    @objc dynamic var image:String = ""
    
}

//class Result: Object {
//    @objc dynamic var apitype: String = ""
//    @objc dynamic var id: String = ""
//    @objc dynamic var name:String = ""
//    @objc dynamic var image:String = ""
//
//}
//


class Favorite: Object {
    @objc dynamic var name: String = ""
    let items = RealmSwift.List<Item>()
}
