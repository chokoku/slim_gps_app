import UIKit

protocol UserInfoViewInterface: class {
}

protocol UserInfoPresenterInterface: class {
    func getUserInfo() -> [String:String]
}

protocol UserInfoWireframeInterface: class {
}

protocol UserInfoInteractorInterface: class {
    func fetchUserInfo(_ uid: String) -> [String:String]
}
