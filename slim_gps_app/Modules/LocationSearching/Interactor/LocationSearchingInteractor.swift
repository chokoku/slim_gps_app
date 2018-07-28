import Foundation
import Firebase
import FirebaseFirestore

final class LocationSearchingInteractor {
    var presenter: LocationSearchingPresenterInterface!
    let db = Firestore.firestore()
    var listener:ListenerRegistration! = nil

    init () {
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
    }
}

extension LocationSearchingInteractor: LocationSearchingInteractorInterface {
    func setLatestLocationListener( deviceID: String ) {
        listener = db.collection("devices").document(deviceID)
            .addSnapshotListener { snap, error in
                guard let doc = snap else {
                    self.presenter.showAlert(message: "位置情報の取得に失敗しました")
                    return
                }
                let docData = doc.data()!
                if  let latitude = docData["latestLatitude"] as? Double,
                    let longitude = docData["latestLongitude"] as? Double,
                    let radius = docData["latestRadius"] as? Double,
                    let updatedAt = docData["updatedAt"] as? Timestamp
                {
                    self.presenter.locationDataIsGotten(latitude: latitude, longitude: longitude, radius: radius, updatedAt: updatedAt.dateValue())
                } else {
                    self.presenter.locationDataIsEmpty(message: "位置情報がありません")
                }
        }
    }
    
    func removeSnapshotListener(){
        listener.remove()
    }
    
    func requestLocationSearching(deviceID: String){
        db.collection("requests").addDocument(data: ["deviceID": deviceID, "createdAt": Date()]) { err in
            if let _ = err {
                self.presenter.showAlert(message: "位置情報のリクエストに失敗しました")
            }
        }
    }
}
