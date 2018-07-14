import Foundation
import Firebase
import FirebaseFirestore

final class MainInteractor {
    var presenter: MainPresenterInterface!
    let db = Firestore.firestore()
    
    init () {
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
    }
}

extension MainInteractor: MainInteractorInterface {
    func getDeviceInfo(uid: String){
        
        db.collection("accessAuth")
            .whereField("clientID", isEqualTo: uid)
            .whereField("confirmed", isEqualTo: true)
            .order(by: "createdAt", descending: false)
            .getDocuments { (accessAuthSnap, error) in
                if let _ = error {
                    self.presenter.showAlert(message:"エラーが発生しました")
                } else if( 0 != accessAuthSnap!.documents.count ){
                    var i = 0
                    for accessAuthDoc in accessAuthSnap!.documents {
                        let deviceID = accessAuthDoc.data()["deviceID"] as! String // serialNum
                        self.db.collection("devices").document(deviceID)
                            .getDocument { (deviceDoc, error) in
                                if let _ = error {
                                    self.presenter.showAlert(message:"エラーが発生しました")
                                } else if deviceDoc == nil {
                                    self.presenter.showAlert(message:"エラーが発生しました")
                                } else {
                                    self.db.collection("locationData")
                                        .whereField("deviceID", isEqualTo: deviceID)
                                        .order(by: "createdAt", descending: true)
                                        .limit(to:1)
                                        .getDocuments { (locationDataSnap, error) in // locationDataSnap can be []
                                            if let _ = error {
                                                self.presenter.showAlert(message:"エラーが発生しました")
                                            } else {
                                                i += 1
                                                let lastFlag: Bool = accessAuthSnap!.documents.count == i
                                                
                                                if(locationDataSnap!.documents.count == 0){
                                                    self.presenter.addMapView( index: i-1, // 0 start
                                                                               lastFlag: lastFlag,
                                                                               deviceID: deviceID,
                                                                               admin: accessAuthDoc.data()["admin"] as! Bool,
                                                                               mode: deviceDoc!["mode"] as! String,
                                                                               name: deviceDoc!["name"] as! String,
                                                                               latitude: nil,
                                                                               longitude: nil,
                                                                               battery: nil )
                                                } else {
                                                    self.presenter.addMapView( index: i-1, // 0 start
                                                                               lastFlag: lastFlag,
                                                                               deviceID: deviceID,
                                                                               admin: accessAuthDoc.data()["admin"] as! Bool,
                                                                               mode: deviceDoc!["mode"] as! String,
                                                                               name: deviceDoc!["name"] as! String,
                                                                               latitude: locationDataSnap!.documents.first?.data()["latitude"] as? Double,
                                                                               longitude: locationDataSnap!.documents.first?.data()["longitude"] as? Double,
                                                                               battery: locationDataSnap!.documents.first?.data()["battery"] as? Int )
                                                }
                                            }
                                    }
                                }
                        }
                    }
                }
        }
    }
}
