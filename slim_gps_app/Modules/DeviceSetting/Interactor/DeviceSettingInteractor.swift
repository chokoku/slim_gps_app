import Foundation
//import Firebase
import FirebaseFirestore

final class DeviceSettingInteractor {
    var presenter: DeviceSettingPresenterInterface!
    let db = Firestore.firestore()
    
    init () {
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
    }
}

extension DeviceSettingInteractor: DeviceSettingInteractorInterface {
    func getAccessAuth(deviceID: String) {
        db.collection("accessAuth")
            .whereField("deviceID", isEqualTo: deviceID)
            .whereField("confirmed", isEqualTo: true)
            .order(by: "createdAt", descending: false)
            .getDocuments { (accessAuthSnap, error) in
                if let _ = error {
                    self.presenter.showAlert(message:"エラーが発生しました")
                } else {
                    for accessAuthDoc in accessAuthSnap!.documents {
                        let clientID = accessAuthDoc.data()["clientID"] as! String
                        self.db.collection("clients").document( clientID ).getDocument { (clientDoc, error) in
                            if let clientDoc = clientDoc, clientDoc.exists {
                                 if let firstName = clientDoc.data()!["firstName"] as? String,
                                    let lastName = clientDoc.data()!["lastName"] as? String,
                                    let admin = accessAuthDoc.data()["admin"] as? Bool
                                 {
                                    self.presenter.accessAuthIsGotten(watcher:(accessAuthID: accessAuthDoc.documentID, firstName: firstName, lastName: lastName, admin: admin))
                                }
                            } else {
                                self.presenter.showAlert(message:"アクセス権のある方の情報が存在しません")
                            }
                        }
                    }
                }
        }
    }
    
    func updateDeviceName(deviceID: String, name:String) {
        db.collection("devices").document(deviceID).updateData(["name": name]) { err in
            if let _ = err {
                self.presenter.showAlert(message:" デバイス情報を更新できませんでした")
            }
        }
    }
    
    func updateDeviceSetting(deviceID: String, mode: String) {
        db.collection("devices").document(deviceID).updateData(["mode": mode]){ err in
            if let _ = err {
                self.presenter.showAlert(message:" デバイス情報を更新できませんでした")
            }
        }
    }
    
    func deleteAccessAuth(accessAuthID: String) {
        db.collection("accessAuth").document(accessAuthID).delete(){ err in
            if let _ = err {
                self.presenter.showAlert(message:" アクセス権をを削除できませんでした")
            }
            self.presenter.accessAuthIsDeleted(accessAuthID:accessAuthID)
        }
    }
}
