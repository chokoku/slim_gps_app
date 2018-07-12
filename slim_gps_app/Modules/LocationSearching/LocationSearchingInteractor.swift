import Foundation
import Firebase
import FirebaseFirestore

final class LocationSearchingInteractor {
    var presenter: LocationSearchingPresenterInterface!
    let db = Firestore.firestore()
    
    init () {
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
    }
}

extension LocationSearchingInteractor: LocationSearchingInteractorInterface {
    func getLatestLocationData( serialNum: String ) {
        db.collection("location_data")
            .whereField("device_id", isEqualTo: serialNum)
            .order(by: "created_at", descending: true)
            .limit(to:1)
            .addSnapshotListener { (querySnapshot, err) in
                if let _ = err {
                    self.presenter.showAlert(message: "位置情報の取得に失敗しました")
                } else {
                    for document in querySnapshot!.documents {
                        if  let latitude = document.data()["latitude"] as? Double,
                            let longitude = document.data()["longitude"] as? Double,
                            let radius = document.data()["radius"] as? Double,
                            let createdAt = document.data()["created_at"] as? Timestamp
                        {
                            self.presenter.locationDataIsGotten(latitude: latitude, longitude: longitude, radius: radius, createdAt: createdAt.dateValue())
                        }
                    }
                }
        }
    }
    
    func requestLocationSearching(device_id: String){
        db.collection("requests").addDocument(data: ["device_id": device_id, "createdAt": Date()]) { err in
            if let _ = err {
                self.presenter.showAlert(message: "位置情報のリクエストに失敗しました")
            }
        }
    }
}
