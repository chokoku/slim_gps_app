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
        db.collection("clientToDevice")
            .whereField(uid, isGreaterThanOrEqualTo: 0)
            .getDocuments { (clientToDeviceSnap, error) in
                if let error = error {
                    CommonFunc.addErrorReport(category: "Main-01", description: error.localizedDescription)
                    self.presenter.showAlert(message:"エラーが発生しました")
                } else if( clientToDeviceSnap!.documents.count != 0 ){
                    var i = 0
                    for clientToDeviceDoc in clientToDeviceSnap!.documents {
                        Thread.sleep(forTimeInterval:0.1)
                        let deviceID = clientToDeviceDoc.documentID
                        self.db.collection("devices").document(deviceID)
                            .getDocument { (deviceDoc, error) in
                                if let error = error {
                                    CommonFunc.addErrorReport(category: "Main-02", description: error.localizedDescription)
                                    self.presenter.showAlert(message:"エラーが発生しました")
                                } else if deviceDoc == nil {
                                    CommonFunc.addErrorReport(category: "Main-03", description: "deviceDoc does not exist")
                                    self.presenter.showAlert(message:"エラーが発生しました")
                                } else {
                                    i += 1
                                    self.presenter.addMapView( index: i-1, // 0 start
                                                               lastFlag: clientToDeviceSnap!.documents.count == i,
                                                               deviceID: deviceID,
                                                               admin: clientToDeviceDoc.data()[uid] as! Int == 1 ? true : false,
                                                               mode: deviceDoc!["mode"] as! String,
                                                               name: deviceDoc!["name"] as! String,
                                                               latitude: deviceDoc!["latestLatitude"] as? Double,
                                                               longitude: deviceDoc!["latestLongitude"] as? Double,
                                                               battery: deviceDoc!["latestBattery"] as? Int  )
                                }
                        }
                    }
                }
        }
    }
}
