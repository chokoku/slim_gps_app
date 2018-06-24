import UIKit

protocol UserInfoViewInterface: class {
}

protocol UserInfoPresenterInterface: class {
    func getUserInfo()
}

protocol UserInfoWireframeInterface: class {
}

protocol UserInfoInteractorInterface: class {
    func fetchUserInfo(_ userId: String)
}
