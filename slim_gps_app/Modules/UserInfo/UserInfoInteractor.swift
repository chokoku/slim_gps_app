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
    func fetchClientInfo(_ uid: String) -> [String:String]{
        var userInfo:[String:String] = [:]
        
        var keepAlive = true
        let runLoop = RunLoop.current
        
        let ref = db.collection("clients").document(uid)
        ref.addSnapshotListener { (document, error) in
            if let document = document, document.exists {
                if let first = document.data()!["first_name"] as? String {
                    userInfo["first_name"] = first
                }
                if let last = document.data()!["last_name"] as? String {
                    userInfo["last_name"] = last
                }
            } else {
                print("Document does not exist")
            }
            keepAlive = false
        }
        
        while keepAlive &&
            runLoop.run(mode: RunLoopMode.defaultRunLoopMode, before: NSDate(timeIntervalSinceNow: 0.1) as Date) {
        }
        return userInfo
    }
    
    func updateClientEmail(_ email: String){
        Auth.auth().currentUser?.updateEmail(to: email) { (error) in
            print("email:\(email)")
            if let error = error {
                print("error:\(error)")
                self.presenter.showAlert(message: "パスワードが間違っています")
            }
            let user = Auth.auth().currentUser
            print("updated email:\(user!.email)")
            print("updated uid:\(user!.uid)")
            // TODO bug firebase authentication does not update

        }
    }
    
    func updateClientInfo(uid: String, item: String, input: String){
        db.collection("clients").document(uid).updateData([
            item: input
        ]) { error in
            if let _ = error {
                self.presenter.showAlert(message: "ユーザー情報を更新できませんでした。")
            }
        }
    }
}
