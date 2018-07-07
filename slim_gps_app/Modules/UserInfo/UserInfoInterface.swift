import UIKit

protocol UserInfoViewInterface: class {
    func showAlert(message: String)
}

protocol UserInfoPresenterInterface: class {
    func getUserInfo() -> [String:String]
    func logout()
    func updateUserInfo(item: String, input: String)
    func updateUserEmail(email: String, password: String)
    func showAlert(message: String)
}

protocol UserInfoWireframeInterface: class {
    func getMainPage()
}

protocol UserInfoInteractorInterface: class {
    func fetchClientInfo(_ uid: String) -> [String:String]
    func updateClientEmail(_ email: String)
    func updateClientInfo(uid: String, item: String, input: String)
}
