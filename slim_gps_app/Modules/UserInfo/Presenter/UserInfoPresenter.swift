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
    func getUserInfo(){
        _interactor.getUserInfo()
    }
    
    func logout(){
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            _wireframe.logout()
        } catch let signOutError as NSError {
            CommonFunc.addErrorReport(category: "UserInfo-06", description: signOutError.localizedDescription)
//            print ("Error signing out: %@", signOutError)
        }
//        try! Auth.auth().signOut()
//        _wireframe.logout()
    }
    
    func setUserInfoForm(userInfo: [String:String]){
        if let _view = _view {
            _view.setUserInfoForm(userInfo: userInfo)
        }
    }
    
    func showAlert(message:String){
        if let _view = _view {
            _view.showAlert(message: message)
        }
    }
    
    func logOutForError(message:String){
        if let _view = _view {
            _view.logOutForError(message: message)
        }
    }
    
    func updateUserInfo(key: String, value: String){
        _interactor.updateUserInfo(key: key, value: value)
    }
    
    func updateUserEmail(email: String, password: String){
        let user = Auth.auth().currentUser
        Auth.auth().signIn(withEmail: user!.email!, password: password) { (user, err) in
            if let _ = err {
                if let _view = self._view {
                    _view.showAlert(message: "パスワードが正しくありません")
                }
            } else {
                self._interactor.updateUserEmail(email: email)
            }
        }
    }
    
    func emailIsUpdated(email: String){
        _view!.emailIsUpdated(email: email)
    }
}


