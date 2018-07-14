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
        try! Auth.auth().signOut()
        _wireframe.logout()
    }
    
    func setUserInfoForm(userInfo: [String:String]){
        _view!.setUserInfoForm(userInfo: userInfo)
    }
    
    func showAlert(message:String){
        _view!.showAlert(message: message)
    }
    
    func updateUserInfo(key: String, value: String){
        _interactor.updateUserInfo(key: key, value: value)
    }
    
    func updateUserEmail(email: String, password: String){
        let user = Auth.auth().currentUser
        Auth.auth().signIn(withEmail: user!.email!, password: password) { (user, err) in
            if let _ = err {
                self._view!.showAlert(message: "パスワードが正しくありません")
            } else {
                self._interactor.updateUserEmail(email: email)
            }
        }
    }
    
    func emailIsUpdated(email: String){
        _view!.emailIsUpdated(email: email)
    }
}


