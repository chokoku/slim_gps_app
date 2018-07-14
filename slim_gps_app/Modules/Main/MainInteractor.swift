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
    func getDeviceInfo(uid: String) -> [(serialNum: String?, admin: Bool?, mode: String?, name: String?, latitude: Double?, longitude: Double?, battery: Int?)]{
        
        var locationData = [(serialNum: String?, admin: Bool?, mode: String?, name: String?, latitude: Double?, longitude: Double?, battery: Int?)]()
    
        var keepAlive = true
        let runLoop = RunLoop.current
        var i = 0
        
        db.collection("accessAuth")
            .whereField("clientID", isEqualTo: uid)
            .order(by: "createdAt", descending: false)
            .addSnapshotListener { (accessAuthSnap, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else if( 0 == accessAuthSnap!.documents.count ){
                    keepAlive = false
                } else {
                    for accessAuthDoc in accessAuthSnap!.documents {
                        let deviceID = accessAuthDoc.data()["deviceID"] as! String // serialNum
                        self.db.collection("devices").document(deviceID)
                            .addSnapshotListener { (deviceDoc, error) in
                                if let error = error {
                                    print("Error getting documents: \(error)")
//                                } else if deviceDoc is nil {
//                                  print("Document data: \(dataDescription)")
                                } else {
                                    self.db.collection("locationData") // TODO need to create locationData collection at first
                                        .whereField("deviceID", isEqualTo: deviceID)
                                        .order(by: "createdAt", descending: true)
                                        .limit(to:1)
                                        .addSnapshotListener { (locationDataSnap, error) in
                                            if let error = error {
                                                print("Error getting documents: \(error)")
                                            } else {
                                                if(locationDataSnap!.documents.count == 0){
                                                    locationData += [( deviceID,
                                                                       accessAuthDoc.data()["admin"] as? Bool,
                                                                       deviceDoc!["mode"] as? String,
                                                                       deviceDoc!["name"] as? String,
                                                                       nil,
                                                                       nil,
                                                                       nil )]
                                                } else {
                                                    for locationDataDoc in locationDataSnap!.documents {
                                                        locationData += [(deviceID,
                                                                          accessAuthDoc.data()["admin"] as? Bool,
                                                                          deviceDoc!["mode"] as? String,
                                                                          deviceDoc!["name"] as? String,
                                                                          locationDataDoc.data()["latitude"] as? Double,
                                                                          locationDataDoc.data()["longitude"] as? Double,
                                                                          locationDataDoc.data()["battery"] as? Int)]
                                                    }
                                                }
                                                i += 1
                                                if( i >= accessAuthSnap!.documents.count ){ keepAlive = false }
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
