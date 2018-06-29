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
        userInfoFromCL = _interactor.fetchUserInfo(user!.uid)
        userInfo["first_name"] = userInfoFromCL["first_name"]
        userInfo["last_name"] = userInfoFromCL["last_name"]
        
        return userInfo
    }
}


