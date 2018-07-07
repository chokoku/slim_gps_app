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
    func getUserInfo() -> [String:String]{
        var userInfo:[String:String] = [:]
        var userInfoFromCL:[String:String] = [:]
        let user = Auth.auth().currentUser

        // get email from firebase authentication
        userInfo["email"] = user!.email!
        
        // get first_name and last_name for cloud functions
        userInfoFromCL = _interactor.fetchClientInfo(user!.uid)
        userInfo["last_name"] = userInfoFromCL["last_name"]
        userInfo["first_name"] = userInfoFromCL["first_name"]
        
        return userInfo
    }
    
    func logout(){
        try! Auth.auth().signOut()
        _wireframe.getMainPage()
    }
    
    func updateUserInfo(item: String, input: String){
        let user = Auth.auth().currentUser
        _interactor.updateClientInfo(uid: user!.uid, item: item, input: input) //first name or last name
    }
    
    func updateUserEmail(email: String, password: String){
        print("email:\(email)")
        let user = Auth.auth().currentUser

        Auth.auth().signIn(withEmail: user!.email!, password: password) { (user, error) in
            if let error = error {
                print("error:\(error)")
                self.showAlert(message: "パスワードが間違っています")
            } else {
                self._interactor.updateClientEmail(email)

            }
        }
    }


    func showAlert(message: String){
        _view!.showAlert(message: message)
    }

}


