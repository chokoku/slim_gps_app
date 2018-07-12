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
        db.collection("access_auth")
            .whereField("device_id", isEqualTo: deviceID)
            .whereField("confirmed", isEqualTo: true)
            .order(by: "created_at", descending: false)
            .getDocuments { (access_auth_querySnapshot, error) in // addSnapshotListener does not work. bug?
                if let _ = error {
                    self.presenter.showAlert(message:"エラーが発生しました")
                } else {
                    for access_auth_document in access_auth_querySnapshot!.documents {
                        let client_id = access_auth_document.data()["client_id"] as! String
                        self.db.collection("clients").document( client_id ).addSnapshotListener { (client_document, error) in
                            if let client_document = client_document, client_document.exists {
                                 if let firstName = client_document.data()!["first_name"] as? String,
                                    let lastName = client_document.data()!["last_name"] as? String,
                                    let admin = access_auth_document.data()["admin"] as? Bool
                                 {
                                    self.presenter.accessAuthIsGotten(watcher:(accessAuthID: access_auth_document.documentID, firstName: firstName, lastName: lastName, admin: admin))
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
        db.collection("access_auth").document(accessAuthID).delete(){ err in
            if let _ = err {
                self.presenter.showAlert(message:" アクセス権をを削除できませんでした")
            }
            self.presenter.accessAuthIsDeleted(accessAuthID:accessAuthID)
        }
    }
}
