import Foundation
import Firebase
//import FirebaseAuth

final class UserInfoInteractor {
    var output: UserInfoPresenterInterface!
}

extension UserInfoInteractor: UserInfoInteractorInterface {
    
    func fetchUserInfo(_ uid: String) -> [String:String]{
        var userInfo:[String:String] = [:]
        let db = Firestore.firestore()
//        let settings = db.settings
//        settings.areTimestampsInSnapshotsEnabled = true
//        db.settings = settings
//        let user = Auth.auth().currentUser
//        print("user:\(user)")

        print("uid:\(uid)")
        let semaphore = DispatchSemaphore(value:0)
        let queue = DispatchQueue.global()
        queue.sync {
            let ref = db.collection("clients").document(uid)

            print("ref: \(ref)")
            ref.getDocument { (document, error) in
                print("here3")
                if let document = document, document.exists {
                    print("first_name:\(document.data()!["first_name"])")
                    print("last_name:\(document.data()!["last_name"])")
                    if let first = document.data()!["first_name"] as? String {
                        userInfo["first_name"] = first
                    }
                    if let last = document.data()!["last_name"] as? String {
                        userInfo["last_name"] = last
                    }
                    semaphore.signal()
                } else {
                    print("Document does not exist")
                    semaphore.signal()
                }
            }
        }

        
        semaphore.wait()
        print("userInfo:\(userInfo)")
        return userInfo
    }
}
