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
    
    func updateAccessAuth(serialNum: String, uid: String, completion: @escaping (String?) -> Void ){
        db.collection("devices").document(serialNum).getDocument { (document, err) in
            if let _ = err {
                completion("エラーが発生しました")
            } else {
                if let document = document, document.exists {
                    self.db.collection("access_auth")
                        .whereField("device_id", isEqualTo: serialNum)
                        .whereField("client_id", isEqualTo: uid)
                        .limit(to:1)
                        .getDocuments { (querySnapshot, err) in // addSnapshotListener does not work. firestore bug
                            if let _ = err {
                                completion("エラーが発生しました")
                            } else {
                                if(querySnapshot!.documents.count == 0){
                                    self.db.collection("access_auth")
                                        .whereField("device_id", isEqualTo: serialNum)
                                        .whereField("admin", isEqualTo: true)
                                        .limit(to:1)
                                        .getDocuments { (querySnapshot, err) in
                                            if let _ = err {
                                                completion("エラーが発生しました")
                                            } else {
                                                for document in querySnapshot!.documents {
                                                    // create access_auth document
                                                    self.db.collection("access_auth").addDocument(data: ["device_id": serialNum,
                                                                                                         "client_id": uid,
                                                                                                         "owner_id": document.data()["uid"] as! String,
                                                                                                         "confirmed": false,
                                                                                                         "created_at": Date()]) { err in
                                                                                                            if let _ = err {
                                                                                                                completion("アクセス権の申請に失敗しました")
                                                                                                            } else {
                                                                                                                // TODO request notification
                                                                                                                completion(nil)
                                                                                                            }
                                                    }
                                                }
                                            }
                                    }
                                } else {
                                    for document in querySnapshot!.documents {
                                        if(document.data()["confirmed"] as! Bool){ // already approved
                                            completion("すでにアクセス権をお持ちです")
                                        } else { // already requested
                                            completion("すでに申請済みです")
                                        }
                                    }
                                }
                            }
                    }
                } else {
                    completion("デバイスが存在しません")
                }
            }
        }
    }
}
