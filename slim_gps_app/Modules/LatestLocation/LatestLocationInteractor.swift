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
        db.collection("locationData")
            .whereField("deviceID", isEqualTo: serialNum)
            .order(by: "createdAt", descending: true)
            .limit(to:1)
            .addSnapshotListener { (snap, err) in
                if let _ = err {
                    self.presenter.showAlert(message: "位置情報の取得に失敗しました")
                } else {
                    if(snap!.documents.count == 0){
                        self.presenter.showAlert(message: "位置情報のデータがありません")
                    } else {
                        for document in snap!.documents {
                            if  let latitude = document.data()["latitude"] as? Double,
                                let longitude = document.data()["longitude"] as? Double,
                                let radius = document.data()["radius"] as? Double,
                                let createdAt = document.data()["createdAt"] as? Timestamp
                            {
                                self.presenter.locationDataIsGotten(latitude: latitude, longitude: longitude, radius: radius, createdAt: createdAt.dateValue())
                            }
                        }
                    }
                }
        }
    }
}
