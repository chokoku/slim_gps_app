import Foundation
import Firebase
import FirebaseFirestore

final class LatestLocationInteractor {
    var presenter: LatestLocationPresenterInterface!
    let db = Firestore.firestore()
    var listener:ListenerRegistration! = nil
    
    init () {
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
    }
}

extension LatestLocationInteractor: LatestLocationInteractorInterface {
    
    func getNotifSpots(){
        let user = Auth.auth().currentUser
        db.collection("notifSpots")
            .whereField("clientID", isEqualTo: user!.uid)
            .getDocuments { (snap, error) in
                if let error = error {
                    CommonFunc.addErrorReport(category: "DeviceSetting-04", description: error.localizedDescription)
                    self.presenter.showAlert(message: "通知スポットの取得に失敗しました")
                } else {
                    if(snap!.documents.count == 0){ self.presenter.giveLastNotifSpotFlag() }
                    var i = 0
                    for document in snap!.documents {
                        i += 1
                        let data = document.data()
                        if  let latitude = data["latitude"] as? Double,
                            let longitude = data["longitude"] as? Double,
                            let radius = data["radius"] as? Double
                        {
                            self.presenter.showNotifSpot(latitude: latitude, longitude: longitude, radius: radius)
                        }
                        if(snap!.documents.count == i){
                            Thread.sleep(forTimeInterval:0.1)
                            self.presenter.giveLastNotifSpotFlag()
                        }
                    }
                }
        }
    }
    
    func setLatestLocationListener( deviceID: String ) {
        listener = db.collection("devices").document(deviceID)
            .addSnapshotListener { snap, error in
                guard let doc = snap else {
                    CommonFunc.addErrorReport(category: "LatestLocation-01", description: error!.localizedDescription)
                    self.presenter.showAlert(message: "位置情報の取得に失敗しました")
                    return
                }
                let docData = doc.data()!
                if  let latitude = docData["latestLatitude"] as? Double,
                    let longitude = docData["latestLongitude"] as? Double,
                    let radius = docData["latestRadius"] as? Double,
                    let updatedAt = docData["updatedHbAt"] as? Timestamp
                {
                    self.presenter.locationDataIsGotten(latitude: latitude, longitude: longitude, radius: radius, updatedAt: updatedAt.dateValue())
                } else {
                    self.presenter.locationDataIsEmpty(message: "位置情報がありません")
                }
        }
    }
    
    func removeSnapshotListener(){
        if(listener != nil) {
            listener.remove()
        }
    }

}
