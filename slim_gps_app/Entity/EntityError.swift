//class EntityError {
//
//    var id   : String
//    var name : String = ""
//    var num  : Int = 0
//
//    init(json: JSON) { // SwiftJsonとか使っている前提
//        self.id   = json["id"].string ?? ""
//        self.name = json["info"]["name"].string ?? ""
//        self.num  = json["info"]["num"].int ?? 0
//    }
//
//    static func createList(from json: JSON) -> [SomeData] {
//        return (json["items"].array ?? []).map { json -> SomeData in return SomeData(json: json) }
//    }
//}
