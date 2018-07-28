import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth

final class NotifSpotInteractor {
    var presenter: NotifSpotPresenterInterface!
    let db = Firestore.firestore()
    
    init () {
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
    }
}

extension NotifSpotInteractor: NotifSpotInteractorInterface {
    func getNotifSpots(){
        let user = Auth.auth().currentUser
        db.collection("notifSpots")
            .whereField("clientID", isEqualTo: user!.uid)
            .getDocuments { (snap, error) in
                if let _ = error {
                    self.presenter.showAlert(message: "通知スポットの取得に失敗しました")
                } else {
                    for document in snap!.documents {
                        let data = document.data()
                        if  let name = data["name"] as? String,
                            let latitude = data["latitude"] as? Double,
                            let longitude = data["longitude"] as? Double,
                            let radius = data["radius"] as? Double
                        {
                            self.presenter.showNotifSpot(notifSpotID: document.documentID, name: name, latitude: latitude, longitude: longitude, radius: radius)
                        }
                    }
                }
        }
    }
    
    func addNotifSpot(name: String, latitude: Double, longitude: Double, radius: Double) {
        let user = Auth.auth().currentUser
        var ref: DocumentReference? = nil
        ref = db.collection("notifSpots").addDocument(data: ["clientID": user!.uid, "name": name, "latitude": latitude, "longitude": longitude, "radius": radius])
        presenter.showNotifSpot(notifSpotID: ref!.documentID, name: name, latitude: latitude, longitude: longitude, radius: radius)
    }
    
    func updateNotifSpot(notifSpotID: String, name: String, tag: Int){
        db.collection("notifSpots").document(notifSpotID).updateData([ "name": name ]) { err in
            if let _ = err {
                self.presenter.showAlert(message: "通知スポットの追加に失敗しました")
            } else {
                self.presenter.notifSpotIsUpdated(name: name, tag: tag)
            }
        }
    }
    
    func deleteNotifSpot(notifSpotID: String){
        db.collection("notifSpots").document(notifSpotID).delete() { err in
            if let _ = err {
                self.presenter.showAlert(message: "通知スポットの追加に失敗しました")
            } else {
                self.presenter.notifSpotIsDeleted(notifSpotID: notifSpotID)
            }
        }
    }
}