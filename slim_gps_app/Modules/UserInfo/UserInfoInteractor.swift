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

        
        db.collection("clients").document(user!.uid).getDocument { (document, err) in // addSnapshotListener does not work here. bug
            if let _ = err {
                self.presenter.showAlert(message:"エラーが発生しました")
            } else if let document = document, document.exists {
                if let firstName = document.data()!["first_name"] as? String, let lastName = document.data()!["last_name"] as? String {
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

        var key2 = String()
        if(key == "firstName"){
            key2 = "first_name"
        } else if(key == "lastName"){
            key2 = "last_name"
        } else {
            self.presenter.showAlert(message:"姓名が空白です")
        }

        db.collection("clients").document(user!.uid).updateData([ key2: value ]){ err in
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
