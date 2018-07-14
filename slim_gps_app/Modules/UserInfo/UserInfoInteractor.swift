import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth

final class UserInfoInteractor {
    var presenter: UserInfoPresenterInterface!
    let db = Firestore.firestore()
    
    init () {
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
    }
}

extension UserInfoInteractor: UserInfoInteractorInterface {
    func getUserInfo(){
        let user = Auth.auth().currentUser
        
        db.collection("clients").document(user!.uid).getDocument { (doc, err) in // addSnapshotListener does not work here. bug
            if let _ = err {
                self.presenter.showAlert(message:"エラーが発生しました")
            } else if let doc = doc, doc.exists {
                if let firstName = doc.data()!["firstName"] as? String, let lastName = doc.data()!["lastName"] as? String {
                    self.presenter.setUserInfoForm(userInfo: ["email": user!.email! , "firstName": firstName, "lastName": lastName])
                } else {
                    self.presenter.showAlert(message:"姓名が空白です")
                }
            } else {
                self.presenter.showAlert(message:"データがありません")
            }
        }
    }
    
    func updateUserInfo(key: String, value: String){
        let user = Auth.auth().currentUser

        db.collection("clients").document(user!.uid).updateData([ key: value ]){ err in
            if let _ = err {
                self.presenter.showAlert(message: "ユーザー情報を更新できませんでした")
            }
        }
    }
    
    func updateUserEmail(email: String) {
        Auth.auth().currentUser?.updateEmail(to: email) { (err) in
            if let _ = err {
                self.presenter.showAlert(message:"ユーザー認証に失敗しました")
            } else {
                // TODO bug firebase authentication does not update
                self.presenter.emailIsUpdated(email: email)
            }
        }
    }
}
