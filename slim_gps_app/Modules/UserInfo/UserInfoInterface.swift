import UIKit

protocol UserInfoPresenterInterface: class {
    
    // To View
    func setUserInfoForm(userInfo: [String:String])
    func emailIsUpdated(email: String)
    func showAlert(message:String)
    func logOutForError(message:String)

    // To Interactor
    func getUserInfo()
    func updateUserInfo(key: String, value: String)
    func updateUserEmail(email: String, password: String)
    
    // To Wireframe
    func logout()
}

protocol UserInfoViewInterface: class {
    func setUserInfoForm(userInfo: [String:String])
    func emailIsUpdated(email: String)
    func showAlert(message:String)
    func logOutForError(message:String)
}

protocol UserInfoInteractorInterface: class {
    func getUserInfo()
    func updateUserInfo(key: String, value: String)
    func updateUserEmail(email: String)
}

protocol UserInfoWireframeInterface: class {
    func logout()
}
