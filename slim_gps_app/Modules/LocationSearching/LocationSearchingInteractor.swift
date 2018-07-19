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
        listener = db.collection("locationData")
            .whereField("deviceID", isEqualTo: deviceID)
            .order(by: "createdAt", descending: true)
            .limit(to:1)
            .addSnapshotListener { (snap, err) in
                guard let snap = snap else{
                    self.presenter.showAlert(message: "位置情報の取得に失敗しました")
                    return
                }
                if(snap.documents.count == 0){ self.presenter.locationDataIsEmpty(message: "位置情報がありません") }
                snap.documentChanges.forEach{ diff in
                    if (diff.type == .added){
                        let docData = diff.document.data()
                        if  let latitude = docData["latitude"] as? Double,
                            let longitude = docData["longitude"] as? Double,
                            let radius = docData["radius"] as? Double,
                            let createdAt = docData["createdAt"] as? Timestamp
                        {
                            self.presenter.locationDataIsGotten(latitude: latitude, longitude: longitude, radius: radius, createdAt: createdAt.dateValue())
                        }
                    }
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
