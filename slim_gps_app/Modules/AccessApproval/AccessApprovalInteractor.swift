import Foundation
import Firebase
import FirebaseFirestore

final class AccessApprovalInteractor {
    var presenter: AccessApprovalPresenterInterface!
    let db = Firestore.firestore()
    
    init () {
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
    }
}

extension AccessApprovalInteractor: AccessApprovalInteractorInterface {
    
    func fetchRequesters(uid:String){
        db.collection("access_auth")
            .whereField("client_id", isEqualTo: uid)
            .whereField("admin", isEqualTo: true)
            .addSnapshotListener { (accessAuthQuerySnapshot1, err) in
                if let _ = err {
                    self.presenter.pushAlert(message:"エラーが発生しました")
                } else {
                    for accessAuthDocument1 in accessAuthQuerySnapshot1!.documents{
                        let device_id = accessAuthDocument1.data()["device_id"] as! String
                        self.db.collection("access_auth")
                            .whereField("device_id", isEqualTo: device_id)
                            .whereField("admin", isEqualTo: false)
                            .whereField("confirmed", isEqualTo: false)
                            .addSnapshotListener { (accessAuthQuerySnapshot2, err) in
                                if let _ = err {
                                    self.presenter.pushAlert(message:"エラーが発生しました")
                                } else {
                                    for accessAuthDocument2 in accessAuthQuerySnapshot2!.documents{
                                        let requester_id = accessAuthDocument2.data()["client_id"] as! String
                                        self.db.collection("clients").document(requester_id)
                                            .addSnapshotListener { (requesterDocument, err) in
                                                if let _ = err {
                                                    self.presenter.pushAlert(message:"エラーが発生しました")
                                                } else {
                                                    let first_name = requesterDocument!.data()!["first_name"] as? String
                                                    let last_name = requesterDocument!.data()!["last_name"] as? String
                                                    self.presenter.addRequesters(access_auth_id: accessAuthDocument2.documentID, first_name: first_name, last_name: last_name)
                                                }
                                        }
                                    }
                                }
                        }
                    }
                }
        }
        
    }
    
    func approveAccessRequest(access_auth_id: String, completion: @escaping (String?) -> Void){
        var error: String?
        db.collection("access_auth").document(access_auth_id).updateData([ "confirmed": true ]){ err in
            if let _ = err {
                error = "アクセス権を付与できませんでした"
            } else {
                // TODO send notification
            }
            completion(error)
        }
    }
    
    func rejectAccessRequest(access_auth_id: String, completion: @escaping (String?) -> Void){
        var error: String?
        db.collection("access_auth").document(access_auth_id).delete(){ err in
            if let _ = err {
                error = "アクセスリクエストの拒否に失敗しました"
            }
            completion(error)
        }
    }
}
