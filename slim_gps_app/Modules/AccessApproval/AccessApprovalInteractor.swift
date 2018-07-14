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
        db.collection("accessAuth")
            .whereField("clientID", isEqualTo: uid)
            .whereField("admin", isEqualTo: true)
            .addSnapshotListener { (accessAuthSnap1, err) in
                if let _ = err {
                    self.presenter.showAlert(message:"エラーが発生しました")
                } else {
                    for accessAuthDoc1 in accessAuthSnap1!.documents{
                        let deviceID = accessAuthDoc1.data()["deviceID"] as! String
                        self.db.collection("accessAuth")
                            .whereField("deviceID", isEqualTo: deviceID)
                            .whereField("admin", isEqualTo: false)
                            .whereField("confirmed", isEqualTo: false)
                            .addSnapshotListener { (accessAuthSnap2, err) in
                                if let _ = err {
                                    self.presenter.showAlert(message:"エラーが発生しました")
                                } else {
                                    for accessAuthDoc2 in accessAuthSnap2!.documents{
                                        let requesterID = accessAuthDoc2.data()["clientID"] as! String
                                        self.db.collection("clients").document(requesterID)
                                            .addSnapshotListener { (requesterDocument, err) in
                                                if let _ = err {
                                                    self.presenter.showAlert(message:"エラーが発生しました")
                                                } else {
                                                    let firstName = requesterDocument!.data()!["firstName"] as? String
                                                    let lastName = requesterDocument!.data()!["lastName"] as? String
                                                    self.presenter.addRequesters(accessAuthID: accessAuthDoc2.documentID, firstName: firstName, lastName: lastName)
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
        db.collection("accessAuth").document(accessAuthID).updateData([ "confirmed": true ]){ err in
            if let _ = err {
                self.presenter.showAlert(message: "アクセス権を付与できませんでした")
            } else {
                // TODO send notification
                self.presenter.accessAuthIsCompleted(accessAuthID: accessAuthID)
            }
        }
    }
    
    func rejectAccessRequest(accessAuthID: String){
        db.collection("accessAuth").document(accessAuthID).delete(){ err in
            if let _ = err {
                self.presenter.showAlert(message: "アクセスリクエストの拒否に失敗しました")
            } else {
                self.presenter.accessAuthIsCompleted(accessAuthID: accessAuthID)
            }
        }
    }
}
