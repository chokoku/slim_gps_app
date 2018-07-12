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
    
    func getRequesters(uid:String){
        db.collection("access_auth")
            .whereField("client_id", isEqualTo: uid)
            .whereField("admin", isEqualTo: true)
            .addSnapshotListener { (accessAuthQuerySnapshot1, err) in
                if let _ = err {
                    self.presenter.showAlert(message:"エラーが発生しました")
                } else {
                    for accessAuthDocument1 in accessAuthQuerySnapshot1!.documents{
                        let device_id = accessAuthDocument1.data()["device_id"] as! String
                        self.db.collection("access_auth")
                            .whereField("device_id", isEqualTo: device_id)
                            .whereField("admin", isEqualTo: false)
                            .whereField("confirmed", isEqualTo: false)
                            .addSnapshotListener { (accessAuthQuerySnapshot2, err) in
                                if let _ = err {
                                    self.presenter.showAlert(message:"エラーが発生しました")
                                } else {
                                    for accessAuthDocument2 in accessAuthQuerySnapshot2!.documents{
                                        let requester_id = accessAuthDocument2.data()["client_id"] as! String
                                        self.db.collection("clients").document(requester_id)
                                            .addSnapshotListener { (requesterDocument, err) in
                                                if let _ = err {
                                                    self.presenter.showAlert(message:"エラーが発生しました")
                                                } else {
                                                    let firstName = requesterDocument!.data()!["first_name"] as? String
                                                    let lastName = requesterDocument!.data()!["last_name"] as? String
                                                    self.presenter.addRequesters(accessAuthID: accessAuthDocument2.documentID, firstName: firstName, lastName: lastName)
                                                }
                                        }
                                    }
                                }
                        }
                    }
                }
        }
        
    }
    
    func approveAccessRequest(accessAuthID: String){
        db.collection("access_auth").document(accessAuthID).updateData([ "confirmed": true ]){ err in
            if let _ = err {
                self.presenter.showAlert(message: "アクセス権を付与できませんでした")
            } else {
                // TODO send notification
                self.presenter.accessAuthIsCompleted(accessAuthID: accessAuthID)
            }
        }
    }
    
    func rejectAccessRequest(accessAuthID: String){
        db.collection("access_auth").document(accessAuthID).delete(){ err in
            if let _ = err {
                self.presenter.showAlert(message: "アクセスリクエストの拒否に失敗しました")
            } else {
                self.presenter.accessAuthIsCompleted(accessAuthID: accessAuthID)
            }
        }
    }
}
