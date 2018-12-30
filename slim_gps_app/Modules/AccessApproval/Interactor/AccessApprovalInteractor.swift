import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFunctions

final class AccessApprovalInteractor {
    var presenter: AccessApprovalPresenterInterface!
    let db = Firestore.firestore()
    lazy var functions = Functions.functions()

    init () {
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
    }
}

extension AccessApprovalInteractor: AccessApprovalInteractorInterface {
    
    func getRequesters(uid: String){
        db.collection("accessAuthReqs")
            .document(uid)
            .collection("requests")
            .getDocuments { (accessAuthReqSnap, error) in
                if let error = error {
                    CommonFunc.addErrorReport(category: "AccessApproval-01", description: error.localizedDescription)
                    self.presenter.showAlert(message:"エラーが発生しました")
                } else {
                    guard accessAuthReqSnap!.count > 0 else {
                        CommonFunc.addErrorReport(category: "AccessApproval-02", description: "accessAuthReqSnap!.count > 0 is wrong")
                        return
                    }
                    for accessAuthReqDoc in accessAuthReqSnap!.documents {
                        let accessAuthReqID = accessAuthReqDoc.documentID
                        let firstName = accessAuthReqDoc.data()["firstName"] as? String
                        let lastName = accessAuthReqDoc.data()["lastName"] as? String
                        let clientID = accessAuthReqDoc.data()["clientID"] as! String
                        let deviceID = accessAuthReqDoc.data()["deviceID"] as! String
                        self.presenter.addRequesters(accessAuthReqID: accessAuthReqID, firstName: firstName, lastName: lastName, clientID: clientID, deviceID: deviceID)
                    }
                }
        }
    }
    
    func approveAccessRequest(accessAuthReqID: String, clientID: String, deviceID: String){
        functions.httpsCallable("approveAccessRequest").call(["accessAuthReqID": accessAuthReqID, "deviceID": deviceID, "clientID": clientID]) { (result, error) in
            if let error = error {
                CommonFunc.addErrorReport(category: "AccessApproval-03", description: error.localizedDescription)
                self.presenter.showAlert(message:"アクセス権をを付与できませんでした")
            } else {
                self.presenter.accessAuthIsCompleted(accessAuthReqID: accessAuthReqID)
            }
        }
    }
    
    func rejectAccessRequest(accessAuthReqID: String, uid: String){
        db.collection("accessAuthReqs").document(uid).collection("requests").document(accessAuthReqID).delete(){ error in
            if let error = error {
                CommonFunc.addErrorReport(category: "AccessApproval-04", description: error.localizedDescription)
                self.presenter.showAlert(message: "アクセスリクエストの拒否に失敗しました")
            } else {
                self.presenter.accessAuthIsCompleted(accessAuthReqID: accessAuthReqID)
            }
        }
    }
}
