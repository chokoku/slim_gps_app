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
        db.collection("notif_spots")
            .whereField("client_id", isEqualTo: user!.uid)
            .addSnapshotListener { (querySnapshot, error) in
                if let _ = error {
                    self.presenter.showAlert(message: "通知スポットの取得に失敗しました")
                } else {
                    for document in querySnapshot!.documents {
                        let data = document.data()
                        if  let name = data["name"] as? String,
                            let latitude = data["latitude"] as? Double,
                            let longitude = data["longitude"] as? Double,
                            let radius = data["radius"] as? Double
                        {
                            self.presenter.showNotifSpot(notif_spot_id: document.documentID, name: name, latitude: latitude, longitude: longitude, radius: radius)
                        }
                    }
                }
        }
    }
    
    // TODO bug
    func addNotifSpot(name: String, latitude: Double, longitude: Double, radius: Double) -> Void {
        print(3)
        let user = Auth.auth().currentUser
        var ref: DocumentReference? = nil
//        ref = db.collection("notif_spots").addDocument(data: ["client_id": user!.uid, "name": name, "latitude": latitude, "longitude": longitude, "radius": radius]) { err in
//            if let _ = err {
//                self.presenter.showAlert(message: "通知スポットの追加に失敗しました")
//            } else {
//                print(4)
//                self.presenter.showNotifSpot(notif_spot_id: ref!.documentID, name: name, latitude: latitude, longitude: longitude, radius: radius)
//            }
//        }
        ref = db.collection("notif_spots").addDocument(data: ["client_id": user!.uid, "name": name, "latitude": latitude, "longitude": longitude, "radius": radius])
        print(4)
        print(ref!.documentID)
        sleep(1)
        presenter.showNotifSpot(notif_spot_id: ref!.documentID, name: name, latitude: latitude, longitude: longitude, radius: radius)
    }
    
    func updateNotifSpot(notif_spot_id: String, name: String, tag: Int){
        db.collection("notif_spots").document(notif_spot_id).updateData([ "name": name ]) { err in
            if let _ = err {
                self.presenter.showAlert(message: "通知スポットの追加に失敗しました")
            } else {
                self.presenter.notifSpotIsUpdated(name: name, tag: tag)
            }
        }
    }
    
    func deleteNotifSpot(notif_spot_id: String){
        db.collection("notif_spots").document(notif_spot_id).delete() { err in
            if let _ = err {
                self.presenter.showAlert(message: "通知スポットの追加に失敗しました")
            } else {
                self.presenter.notifSpotIsDeleted(notif_spot_id: notif_spot_id)
            }
        }
    }
}
