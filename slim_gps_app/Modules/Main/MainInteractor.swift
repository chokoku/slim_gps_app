import Foundation
import Firebase
import FirebaseFirestore

final class MainInteractor {
    var presenter: MainPresenterInterface!
    let db = Firestore.firestore()
    
    init () {
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
    }
}

extension MainInteractor: MainInteractorInterface {
    func fetchDeviceInfo(uid: String) -> [(serial_num: String?, admin: Bool?, mode: String?, name: String?, latitude: Double?, longitude: Double?, battery: Int?)]{
        
        var locationData = [(serial_num: String?, admin: Bool?, mode: String?, name: String?, latitude: Double?, longitude: Double?, battery: Int?)]()
    
        var keepAlive = true
        let runLoop = RunLoop.current
        var i = 0
        
        db.collection("access_auth")
            .whereField("client_id", isEqualTo: uid)
            .order(by: "created_at", descending: false)
            .addSnapshotListener { (access_auth_querySnapshot, error) in
                if( 0 == access_auth_querySnapshot!.documents.count ){ keepAlive = false }
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    for access_auth_document in access_auth_querySnapshot!.documents {
                        let device_id = access_auth_document.data()["device_id"] as! String // serial_num
                        self.db.collection("devices").document(device_id)
                            .addSnapshotListener { (device_document, error) in
                                if let error = error {
                                    print("Error getting documents: \(error)")
//                                } else if device_document is nil {
//                                  print("Document data: \(dataDescription)")
                                } else {
                                    self.db.collection("location_data") // TODO need to create location_data collection at first
                                        .whereField("device_id", isEqualTo: device_id)
                                        .order(by: "created_at", descending: true)
                                        .limit(to:1)
                                        .addSnapshotListener { (location_data_querySnapshot, error) in
                                            if let error = error {
                                                print("Error getting documents: \(error)")
                                            } else {
                                                if(location_data_querySnapshot!.documents.count == 0){
                                                    locationData += [(device_id,
                                                                      access_auth_document.data()["admin"] as? Bool,
                                                                      device_document!["mode"] as? String,
                                                                      device_document!["name"] as? String,
                                                                      nil,
                                                                      nil,
                                                                      nil )]
                                                } else {
                                                    for location_data_document in location_data_querySnapshot!.documents {
                                                        locationData += [(device_id,
                                                                          access_auth_document.data()["admin"] as? Bool,
                                                                          device_document!["mode"] as? String,
                                                                          device_document!["name"] as? String,
                                                                          location_data_document.data()["latitude"] as? Double,
                                                                          location_data_document.data()["longitude"] as? Double,
                                                                          location_data_document.data()["battery"] as? Int)]
                                                    }
                                                }
                                                i += 1
                                                if( i >= access_auth_querySnapshot!.documents.count ){ keepAlive = false }
                                            }
                                    }
                                }
                        }
                    }
                }
        }
        
        while keepAlive &&
            runLoop.run(mode: RunLoopMode.defaultRunLoopMode, before: NSDate(timeIntervalSinceNow: 0.1) as Date) {
        }
        
        return locationData
    }
}
