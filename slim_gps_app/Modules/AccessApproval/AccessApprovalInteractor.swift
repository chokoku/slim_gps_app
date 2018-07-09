import Foundation
import Firebase
import FirebaseFirestore

final class AccessApprovalInteractor {
    var presenter: AccessApprovalPresenterInterface!
    let db = Firestore.firestore()
    
    init () {
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
    }
}

extension AccessApprovalInteractor: AccessApprovalInteractorInterface {
    func fetchRequesters(uid:String) -> [(access_auth_id: String, first_name: String?, last_name: String?)]{
        
        var requesters = [(access_auth_id: String, first_name: String?, last_name: String?)]()
        var keepAlive = true
        let runLoop = RunLoop.current
        var i = 0
        
        // first, get devices which user manages as the admin
        db.collection("access_auth")
            .whereField("owner_id", isEqualTo: uid)
            .whereField("confirmed", isEqualTo: false)
            .addSnapshotListener { (accessAuthQuerySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    if(accessAuthQuerySnapshot!.documents.count == 0){ // the user manages no devices
                        keepAlive = false
                    } else {
                        for accessAuthDocument in accessAuthQuerySnapshot!.documents{
                            let client_id = accessAuthDocument.data()["client_id"] as! String
                            self.db.collection("clients").document(client_id)
                                .addSnapshotListener { (clientDocument, err) in
                                    if let err = err {
                                        print("Error getting documents: \(err)")
                                    } else {
                                        let first_name = clientDocument!.data()!["first_name"] as? String
                                        let last_name = clientDocument!.data()!["last_name"] as? String
                                        requesters += [(accessAuthDocument.documentID, first_name , last_name)]
                                        i += 1
                                        if(accessAuthQuerySnapshot!.documents.count == i){ keepAlive = false }
                                    }
                            }
                        }
                    }
                }
        }
        
        while keepAlive &&
            runLoop.run(mode: RunLoopMode.defaultRunLoopMode, before: NSDate(timeIntervalSinceNow: 0.1) as Date) {
        }
        
        return requesters
    }
}
