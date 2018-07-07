import Foundation
import Firebase
import FirebaseFirestore

final class LatestLocationInteractor {
    var presenter: LatestLocationPresenterInterface!
    let db = Firestore.firestore()
    
    init () {
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
    }
}

extension LatestLocationInteractor: LatestLocationInteractorInterface {
    func fetchLatestLocationData( serial_num: String ) -> (latitude: Double?, longitude: Double?) {
        var locationData: (latitude: Double?, longitude: Double?)
        
        var keepAlive = true
        let runLoop = RunLoop.current
        
        print("serial_num:\(serial_num)")
        
        db.collection("location_data")
            .whereField("device_id", isEqualTo: serial_num)
            .order(by: "created_at", descending: true)
            .limit(to:1)
            .addSnapshotListener { (querySnapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    for document in querySnapshot!.documents {
                        if let latitude = document.data()["latitude"] as? Double, let longitude = document.data()["longitude"] as? Double {
                            locationData = (latitude, longitude)
                        }
                    }
                    keepAlive = false
                }
        }
        
        
        while keepAlive &&
            runLoop.run(mode: RunLoopMode.defaultRunLoopMode, before: NSDate(timeIntervalSinceNow: 0.1) as Date) {
        }
        
        return locationData
    }
}
