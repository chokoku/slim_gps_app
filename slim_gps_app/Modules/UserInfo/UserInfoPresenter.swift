import Foundation
import FirebaseAuth

final class UserInfoPresenter {
    
    private weak var _view: UserInfoViewInterface?
    private var _wireframe: UserInfoWireframeInterface
    private var _interactor: UserInfoInteractorInterface

    init(wireframe: UserInfoWireframeInterface, view: UserInfoViewInterface, interactor: UserInfoInteractorInterface) {
        _wireframe = wireframe
        _view = view
        _interactor = interactor
    }
}

extension UserInfoPresenter: UserInfoPresenterInterface {
    func getUserInfo(completion: @escaping ([String:String?], String?) -> Void){
        var userInfo = [String:String?]()
        var error: String?
        let user = Auth.auth().currentUser

        _interactor.fetchClientInfo(uid: user!.uid){ (userInfoFromCL: [String:String?], err: String?) in
            if let err = err {
                error = err
                completion(userInfo, error)
            } else {
                userInfo = ["email": user!.email!, "lastName": userInfoFromCL["lastName"]!, "firstName": userInfoFromCL["firstName"]!]
                completion(userInfo, nil)
            }
        }
    }
    
    func logout(){
        try! Auth.auth().signOut()
        _wireframe.getMainPage()
    }
    
    func updateUserInfo(item: String, input: String, completion: @escaping (String?) ->Void){
        var error: String?
        let user = Auth.auth().currentUser
        // update first name or last name
        _interactor.updateClientInfo(uid: user!.uid, item: item, input: input){ (err: String?) in
            if let err = err {
                error = err
            }
            completion(error)
        }
    }
    
    func updateUserEmail(email: String, password: String, completion: @escaping (String?) ->Void){
        var error: String?
        
        let user = Auth.auth().currentUser
        Auth.auth().signIn(withEmail: user!.email!, password: password) { (user, err) in
            if let _ = err {
                completion("パスワードが正しくありません")
            } else {
                self._interactor.updateClientEmail(email: email){ (err: String?) in
                    if let err = err {
                        error = err
                    }
                    completion(error)
                }
            }
        }
    }

}


