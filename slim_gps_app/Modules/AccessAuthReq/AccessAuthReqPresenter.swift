import Foundation

final class AccessAuthReqPresenter {
    
    private weak var _view: AccessAuthReqViewInterface?
    private var _wireframe: AccessAuthReqWireframeInterface
    
    init(wireframe: AccessAuthReqWireframeInterface, view: AccessAuthReqViewInterface, interactor: AccessAuthReqInteractorInterface) {
        _wireframe = wireframe
        _view = view
    }
}

extension AccessAuthReqPresenter: AccessAuthReqPresenterInterface {
}
