import Foundation
import Firebase
import FirebaseFirestore

final class AccessAuthReqInteractor {
    var presenter: AccessAuthReqPresenterInterface!
    let db = Firestore.firestore()
    
    init () {
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
    }
}

extension AccessAuthReqInteractor: AccessAuthReqInteractorInterface {
    func createAccessAuthReq(serialNum: String, uid: String){
        db.collection("deviceToClient").whereField(serialNum, isEqualTo: 1)
            .limit(to: 1)
            .getDocuments { (deviceToClientSnap, error) in
                if let error = error {
                    CommonFunc.addErrorReport(category: "AccessAuthReq-01", description: error.localizedDescription)
                    self.presenter.showAlert(message: "エラーが発生しました")
                } else {
                    if(deviceToClientSnap!.documents.count == 0){
                        CommonFunc.addErrorReport(category: "AccessAuthReq-02", description: "device does not exist")
                        self.presenter.showAlert(message: "デバイスが存在しません")
                    } else {
                        self.db.collection("clients").document(uid).getDocument { (doc, error) in
                            if let error = error {
                                CommonFunc.addErrorReport(category: "AccessAuthReq-03", description: error.localizedDescription)
                                self.presenter.showAlert(message:"エラーが発生しました")
                            } else {
                                let adminClientID = deviceToClientSnap!.documents[0].documentID
                                self.db.collection("accessAuthReqs").document(adminClientID).collection("requests").document(uid+"AND"+serialNum)
                                    .getDocument { (accessAuthReqDoc, error) in
                                        if let error = error {
                                            CommonFunc.addErrorReport(category: "AccessAuthReq-04", description: error.localizedDescription)
                                            self.presenter.showAlert(message:"エラーが発生しました")
                                        } else if let accessAuthReqDoc = accessAuthReqDoc, accessAuthReqDoc.exists{
                                            self.presenter.showAlert(message:"すでに申請済みです")
                                        } else {
                                            if let firstName = doc!.data()!["firstName"] as? String,
                                                let lastName = doc!.data()!["lastName"] as? String {
                                                self.db.collection("accessAuthReqs").document(adminClientID).collection("requests").document(uid+"AND"+serialNum)
                                                    .setData([
                                                        "clientID": uid,
                                                        "deviceID": serialNum,
                                                        "firstName": firstName,
                                                        "lastName": lastName
                                                        ]
                                                    ){ error in
                                                        if let error = error {
                                                            CommonFunc.addErrorReport(category: "AccessAuthReq-05", description: error.localizedDescription)
                                                            self.presenter.showAlert(message: "アクセス権の申請に失敗しました")
                                                        } else {
                                                            self.presenter.accessAuthReqIsSubmitted()
                                                        }
                                                }
                                            } else {
                                                self.presenter.showAlert(message:"データがありません")
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
