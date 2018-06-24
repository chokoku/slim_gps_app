import Foundation

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
//        _interactor.fetchUserInfo()
    }
}


