import Foundation
import Firebase
import FirebaseFirestore

final class DeviceSettingInteractor {
    var presenter: DeviceSettingPresenterInterface!
    let db = Firestore.firestore()
    
    init () {
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
    }
}

extension DeviceSettingInteractor: DeviceSettingInteractorInterface {
    func fetchAccessAuth(device_id: String) -> [(access_auth_id: String?, first_name: String?, last_name: String?, admin: Bool?)]{
        var accessAuth = [(access_auth_id: String?, first_name: String?, last_name: String?, admin: Bool?)]()
        
        var keepAlive = true
        let runLoop = RunLoop.current
        var i = 0
        
        db.collection("access_auth").whereField("device_id", isEqualTo: device_id)
            .addSnapshotListener { (access_auth_querySnapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    for access_auth_document in access_auth_querySnapshot!.documents {
                        let client_id = access_auth_document.data()["client_id"] as! String
                        self.db.collection("clients").document( client_id ).addSnapshotListener { (client_document, error) in
                                if let client_document = client_document, client_document.exists {
                                     if let first_name = client_document.data()!["first_name"] as? String,
                                        let last_name = client_document.data()!["last_name"] as? String,
                                        let admin = access_auth_document.data()["admin"] as? Bool
                                    {
                                        accessAuth += [(access_auth_document.documentID, first_name, last_name, admin)]
                                        i += 1
                                        if(i == access_auth_querySnapshot!.documents.count){ keepAlive = false }
                                    }
                                } else {
                                    print("Document does not exist")
                                }
                        }
                    }
                }
        }
        
        while keepAlive &&
            runLoop.run(mode: RunLoopMode.defaultRunLoopMode, before: NSDate(timeIntervalSinceNow: 0.1) as Date) {
        }
        return accessAuth
    }
    
    func updateDeviceName(device_id: String, name:String)  -> Bool {
        var result: Bool = true
        
        var keepAlive = true
        let runLoop = RunLoop.current
        
        db.collection("devices").document(device_id).updateData(["name": name]) { error in
            if let error = error {
                result = false
                print("Error updating document: \(error)")
            }
            keepAlive = false
        }
        
        while keepAlive &&
            runLoop.run(mode: RunLoopMode.defaultRunLoopMode, before: NSDate(timeIntervalSinceNow: 0.1) as Date) {
        }
        
        return result
    }
    
    func updateDeviceSetting(device_id: String, mode: String) {
        db.collection("devices").document(device_id).updateData(["mode": mode])
    }
    
    func deleteAccessAuth(access_auth_id: String) {
        db.collection("access_auth").document(access_auth_id).delete()
    }
}
