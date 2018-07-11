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
    func fetchClientInfo(uid: String, completion: @escaping ([String:String?], String?) -> Void) {
        var userInfo:[String:String?] = [:]
        var error: String?

        db.collection("clients").document(uid).addSnapshotListener{ (document, err) in
            if let _ = err {
                error = "エラーが発生しました"
                completion(userInfo, error)
            } else if let document = document, document.exists {
                if let first = document.data()!["first_name"] as? String {
                    userInfo["firstName"] = first
                }
                if let last = document.data()!["last_name"] as? String {
                    userInfo["lastName"] = last
                }
                completion(userInfo, nil)
            } else {
                error = "データがありません"
                completion(userInfo, error)

            }
        }
    }
    
    func updateClientEmail(email: String, completion: @escaping (String?) ->Void) {
        var error: String?

        Auth.auth().currentUser?.updateEmail(to: email) { (err) in
            if let _ = err {
                error = "パスワードが間違っています"
            }
            completion(error)
            // TODO bug firebase authentication does not update

        }
    }
    
    func updateClientInfo(uid: String, item: String, input: String, completion: @escaping (String?) ->Void){
        var error: String?

        db.collection("clients").document(uid).updateData([ item: input ]){ err in
            if let _ = err {
                error = "ユーザー情報を更新できませんでした"
            }
            completion(error)
        }
    }
}
