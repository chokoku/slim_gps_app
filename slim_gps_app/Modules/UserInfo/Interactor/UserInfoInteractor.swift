import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth
import FirebaseFunctions

final class UserInfoInteractor {
    var presenter: UserInfoPresenterInterface!
    let db = Firestore.firestore()
    let functions = Functions.functions()

    init () {
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
    }
}

extension UserInfoInteractor: UserInfoInteractorInterface {
    func getUserInfo(){
        let user = Auth.auth().currentUser
        db.collection("clients").document(user!.uid).getDocument { (doc, error) in
            if let error = error {
                CommonFunc.addErrorReport(category: "UserInfo-01", description: error.localizedDescription)
                self.presenter.showAlert(message:"エラーが発生しました")
            } else if let doc = doc, doc.exists {
                if let firstName = doc.data()!["firstName"] as? String, let lastName = doc.data()!["lastName"] as? String {
                    self.presenter.setUserInfoForm(userInfo: ["email": user!.email! , "firstName": firstName, "lastName": lastName])
                } else {
                    self.presenter.showAlert(message:"姓名が空白です")
                }
            } else {
                self.presenter.logOutForError(message:"データがありません")
            }
        }
    }
    
    func updateUserInfo(key: String, value: String){
        let user = Auth.auth().currentUser
        db.collection("clients").document(user!.uid).updateData([ key: value ]){ error in
            if let error = error {
                CommonFunc.addErrorReport(category: "UserInfo-02", description: error.localizedDescription)
                self.presenter.showAlert(message: "ユーザー情報を更新できませんでした")
            } else {
                self.functions.httpsCallable("updateUserInfo").call(["key": key, "value": value]) { (result, error) in
                    if let error = error {
                        CommonFunc.addErrorReport(category: "UserInfo-03", description: error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func updateUserEmail(email: String) {
        Auth.auth().currentUser?.updateEmail(to: email) { (error) in // update email in firestore
            if let error = error {
                CommonFunc.addErrorReport(category: "UserInfo-04", description: error.localizedDescription)
                self.presenter.showAlert(message:"ユーザー認証に失敗しました")
            } else {
                self.functions.httpsCallable("updateUserInfo").call(["key": "email", "value": email]) { (result, error) in // update email in sale server
                    if let error = error {
                        CommonFunc.addErrorReport(category: "UserInfo-05", description: error.localizedDescription)
                    }
                }
                self.presenter.emailIsUpdated(email: email)
            }
        }
    }
}
