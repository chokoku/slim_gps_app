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
    
    func getRequesters(uid: String){
        db.collection("accessAuth")
            .whereField("confirmed", isEqualTo: false)
            .whereField("ownerClientID", isEqualTo: uid)
            .getDocuments { (accessAuthSnap, err) in
                if let _ = err {
                    self.presenter.showAlert(message:"エラーが発生しました")
                } else {
                    for accessAuthDoc in accessAuthSnap!.documents{
                        let requesterID = accessAuthDoc.data()["clientID"] as! String
                        self.db.collection("clients").document(requesterID)
                            .getDocument { (requesterDoc, err) in
                                if let _ = err {
                                    self.presenter.showAlert(message:"エラーが発生しました")
                                } else {
                                    let firstName = requesterDoc!.data()!["firstName"] as? String
                                    let lastName = requesterDoc!.data()!["lastName"] as? String
                                    self.presenter.addRequesters(accessAuthID: accessAuthDoc.documentID, firstName: firstName, lastName: lastName)
                                }
                        }
                    }
                }
        }
    }
    
    func approveAccessRequest(accessAuthID: String){
        let uid = Auth.auth().currentUser!.uid
        db.collection("accessAuth").document(accessAuthID).updateData([ "confirmed": true, "ownerClientID": uid ]){ err in
            if let _ = err {
                self.presenter.showAlert(message: "アクセス権を付与できませんでした")
            } else {
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
