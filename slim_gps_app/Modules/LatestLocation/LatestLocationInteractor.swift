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
    func getLatestLocationData( serialNum: String ) {
        db.collection("location_data")
            .whereField("device_id", isEqualTo: serialNum)
            .order(by: "created_at", descending: true)
            .limit(to:1)
            .addSnapshotListener { (querySnapshot, err) in
                if let _ = err {
                    self.presenter.showAlert(message: "位置情報の取得に失敗しました")
                } else {
                    if(querySnapshot!.documents.count == 0){
                        self.presenter.showAlert(message: "位置情報のデータがありません")
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
    }
}
