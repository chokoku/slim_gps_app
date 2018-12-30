import Foundation
import FirebaseFirestore

class CommonFunc {
    static func addErrorReport(category:String, description:String){
        let db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
        db.collection("errors").addDocument(data: ["category": category, "description": description, "createdA": Date()])
    }
}
