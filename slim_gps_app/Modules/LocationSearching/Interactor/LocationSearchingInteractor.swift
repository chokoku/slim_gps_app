import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth

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
    
    func requestLocationSearching(deviceID: String){
        let user = Auth.auth().currentUser
        db.collection("locationReqs").addDocument(data: ["clientID": user!.uid, "deviceID": deviceID, "createdAt": Date()]) { error in
            if let error = error {
                CommonFunc.addErrorReport(category: "LatestLocation-02", description: error.localizedDescription)
                self.presenter.showAlert(message: "位置情報のリクエストに失敗しました")
            }
        }
    }
}
