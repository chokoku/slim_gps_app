import Foundation

final class ContactUsPresenter {
    
    private weak var _view: ContactUsViewInterface?
    private var _wireframe: ContactUsWireframeInterface
    
    init(wireframe: ContactUsWireframeInterface, view: ContactUsViewInterface, interactor: ContactUsInteractorInterface) {
        _wireframe = wireframe
        _view = view
    }
}

extension ContactUsPresenter: ContactUsPresenterInterface {
}
