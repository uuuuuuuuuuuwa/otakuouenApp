import Foundation
import RealmSwift
import SwiftUI


class Item: Object {
    @objc dynamic var apitype: String = ""
    @objc dynamic var id: String = ""
    @objc dynamic var name:String = ""
    
}




class Favorite: Object {
    
    @objc dynamic var name: String = ""
    let items = RealmSwift.List<Item>()
}