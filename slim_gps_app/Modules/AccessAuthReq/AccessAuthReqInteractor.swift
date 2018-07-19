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
    
    func updateAccessAuth( serialNum: String, uid: String ){
        db.collection("devices").document(serialNum).getDocument { (deviceDoc, err) in
            if let _ = err {
                self.presenter.showAlert(message: "エラーが発生しました")
            } else {
                if let deviceDoc = deviceDoc, deviceDoc.exists {
                    self.db.collection("accessAuth")
                        .whereField("deviceID", isEqualTo: serialNum)
                        .whereField("clientID", isEqualTo: uid)
                        .getDocuments { (accessAuthSnap, err) in
                            if let _ = err {
                                self.presenter.showAlert(message: "エラーが発生しました")
                            } else {
                                if(accessAuthSnap!.documents.count == 0){
                                    self.db.collection("accessAuth").addDocument(data: ["admin": false,
                                                                                         "deviceID": serialNum,
                                                                                         "clientID": uid,
                                                                                         "confirmed": false,
                                                                                         "createdAt": Date()]) { err in
                                                                                            if let _ = err {
                                                                                                self.presenter.showAlert(message: "アクセス権の申請に失敗しました")
                                                                                            } else {
                                                                                                self.presenter.accessAuthReqIsSubmitted()
                                                                                            }
                                    }
                                } else {
                                    for accessAuthDoc in accessAuthSnap!.documents {
                                        if(accessAuthDoc.data()["confirmed"] as! Bool){ // already approved
                                            self.presenter.showAlert(message: "すでにアクセス権をお持ちです")
                                        } else { // already requested
                                            self.presenter.showAlert(message: "すでに申請済みです")
                                        }
                                    }
                                }
                            }
                    }
                } else {
                    self.presenter.showAlert(message: "デバイスは存在しません")
                }
            }
        }
    }
}
