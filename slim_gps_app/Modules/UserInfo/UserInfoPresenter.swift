import Foundation

final class UserInfoPresenter {
    
    private weak var _view: UserInfoViewInterface?
    private var _wireframe: UserInfoWireframeInterface
    
    init(wireframe: UserInfoWireframeInterface, view: UserInfoViewInterface, interactor: UserInfoInteractorInterface) {
        _wireframe = wireframe
        _view = view
    }
}

extension UserInfoPresenter: UserInfoPresenterInterface {
//    func getSideMenuPage(_ index: Int){
//        _wireframe.pushSideMenuPage(index)
//    }
}


