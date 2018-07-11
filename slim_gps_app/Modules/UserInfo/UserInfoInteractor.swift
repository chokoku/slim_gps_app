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

        db.collection("clients").document(uid).addSnapshotListener{ (document, err) in
            if let _ = err {
                completion(userInfo, "エラーが発生しました")
            } else if let document = document, document.exists {
                if let first_name = document.data()!["first_name"] as? String {
                    userInfo["firstName"] = first_name
                }
                if let last_name = document.data()!["last_name"] as? String {
                    userInfo["lastName"] = last_name
                }
                print(3)
                completion(userInfo, nil)
            } else {
                completion(userInfo, "データがありません")

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
        print(9)

        var key = String()
        if(item == "firstName"){
            key = "first_name"
        } else if(item == "lastName"){
            key = "last_name"
        } else {
            completion(error)
        }

        db.collection("clients").document(uid).updateData([ key: input ]){ err in
            if let _ = err {
                error = "ユーザー情報を更新できませんでした"
            }
            print(10)
            completion(error)
        }
    }
}
