import Foundation

final class AccessAuthReqPresenter {
    
    private weak var _view: AccessAuthReqViewInterface?
    private var _wireframe: AccessAuthReqWireframeInterface
    private var _interactor: AccessAuthReqInteractorInterface
    
    init(wireframe: AccessAuthReqWireframeInterface, view: AccessAuthReqViewInterface, interactor: AccessAuthReqInteractorInterface) {
        _wireframe = wireframe
        _view = view
        _interactor = interactor
    }
}

extension AccessAuthReqPresenter: AccessAuthReqPresenterInterface {
}
