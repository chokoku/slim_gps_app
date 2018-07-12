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
        db.collection("devices").document(serialNum).addSnapshotListener { (document, err) in
            if let _ = err {
                self.presenter.showAlert(message: "エラーが発生しました")
            } else {
                if let document = document, document.exists {
                    self.db.collection("access_auth")
                        .whereField("device_id", isEqualTo: serialNum)
                        .whereField("client_id", isEqualTo: uid)
                        .getDocuments { (querySnapshot, err) in // addSnapshotListener does not work. firestore bug
                            if let _ = err {
                                self.presenter.showAlert(message: "エラーが発生しました")
                            } else {
                                if(querySnapshot!.documents.count == 0){
                                    self.db.collection("access_auth").addDocument(data: ["admin": false,
                                                                                         "device_id": serialNum,
                                                                                         "client_id": uid,
                                                                                         "confirmed": false,
                                                                                         "created_at": Date()]) { err in
                                                                                            if let _ = err {
                                                                                                self.presenter.showAlert(message: "アクセス権の申請に失敗しました")
                                                                                            } else {
                                                                                                // TODO request notification
                                                                                                print(4)
                                                                                                self.presenter.accessAuthReqIsSubmitted()
                                                                                            }
                                    }
                                } else {
                                    for document in querySnapshot!.documents {
                                        if(document.data()["confirmed"] as! Bool){ // already approved
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
