import Foundation
//import Firebase
import FirebaseFirestore
import FirebaseFunctions

final class DeviceSettingInteractor {
    var presenter: DeviceSettingPresenterInterface!
    let db = Firestore.firestore()
    lazy var functions = Functions.functions()

    init () {
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
    }
}

extension DeviceSettingInteractor: DeviceSettingInteractorInterface {
    func getAccessAuth(deviceID: String) {
        db.collection("deviceToClient")
            .whereField(deviceID, isGreaterThanOrEqualTo: 0)
            .order(by: deviceID, descending: true)
            .getDocuments { (deviceToClientSnap, error) in
                if let error = error {
                    CommonFunc.addErrorReport(category: "DeviceSetting-01", description: error.localizedDescription)
                    self.presenter.showAlert(message:"エラーが発生しました")
                } else {
                    for deviceToClientDoc in deviceToClientSnap!.documents {
                        let clientID = deviceToClientDoc.documentID
                        self.db.collection("clients").document( clientID ).getDocument { (clientDoc, error) in
                            if let error = error {
                                CommonFunc.addErrorReport(category: "DeviceSetting-02", description: error.localizedDescription)
                                self.presenter.showAlert(message:"エラーが発生しました")
                            } else {
                                if let clientDoc = clientDoc, clientDoc.exists {
                                    if let firstName = clientDoc.data()!["firstName"] as? String,
                                        let lastName = clientDoc.data()!["lastName"] as? String,
                                        let admin: Bool = deviceToClientDoc.data()[deviceID] as! Int == 1 ? true : false
                                    {
                                        self.presenter.accessAuthIsGotten(watcher:(clientID: clientDoc.documentID, firstName: firstName, lastName: lastName, admin: admin))
                                    }
                                } else {
                                    self.presenter.showAlert(message:"アクセス権のある方の情報が存在しません")
                                }
                            }
                        }
                    }
                }
        }
    }
    
    func updateDeviceName(deviceID: String, name:String) {
        db.collection("devices").document(deviceID).updateData(["name": name]) { error in
            if let error = error {
                CommonFunc.addErrorReport(category: "DeviceSetting-03", description: error.localizedDescription)
                self.presenter.showAlert(message:" デバイス情報を更新できませんでした")
            }
        }
    }
    
    func updateDeviceSetting(deviceID: String, mode: String) {
        db.collection("devices").document(deviceID).updateData(["mode": mode]){ error in
            if let error = error {
                CommonFunc.addErrorReport(category: "DeviceSetting-04", description: error.localizedDescription)
                self.presenter.showAlert(message:" デバイス情報を更新できませんでした")
            }
        }
    }
    
    func deleteAccessAuth(deviceID: String, clientID: String) {
        functions.httpsCallable("deleteAccessAuth").call(["deviceID": deviceID, "clientID": clientID]) { (result, error) in
            if let error = error {
                CommonFunc.addErrorReport(category: "DeviceSetting-05", description: error.localizedDescription)
                self.presenter.showAlert(message:"アクセス権をを削除できませんでした")
            } else {
                self.presenter.accessAuthIsDeleted(clientID: clientID)
            }
        }
    }
}
