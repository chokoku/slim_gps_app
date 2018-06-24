import Foundation

final class ContactUsPresenter {
    
    private weak var _view: ContactUsViewInterface?
    private var _wireframe: ContactUsWireframeInterface
    private var _interactor: ContactUsInteractorInterface
    
    init(wireframe: ContactUsWireframeInterface, view: ContactUsViewInterface, interactor: ContactUsInteractorInterface) {
        _wireframe = wireframe
        _view = view
        _interactor = interactor
    }
}

extension ContactUsPresenter: ContactUsPresenterInterface {
}
