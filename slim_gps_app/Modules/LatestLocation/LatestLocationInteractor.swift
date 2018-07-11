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
    func fetchLatestLocationData( serialNum: String, completion: @escaping (Double?, Double?, String?) -> Void ) { // latitude, longitude, error
        db.collection("location_data")
            .whereField("device_id", isEqualTo: serialNum)
            .order(by: "created_at", descending: true)
            .limit(to:1)
            .addSnapshotListener { (querySnapshot, err) in
                if let _ = err {
                    completion(nil, nil, "位置情報の取得に失敗しました")
                } else {
                    for document in querySnapshot!.documents {
                        if let latitude = document.data()["latitude"] as? Double, let longitude = document.data()["longitude"] as? Double {
                            completion(latitude, longitude, nil)
                        }
                    }
                }
        }
    }
}
