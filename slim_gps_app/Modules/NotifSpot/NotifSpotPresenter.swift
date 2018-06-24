import Foundation

final class NotifSpotPresenter {
    
    private weak var _view: NotifSpotViewInterface?
    private var _wireframe: NotifSpotWireframeInterface
    private var _interactor: NotifSpotInteractorInterface
    
    init(wireframe: NotifSpotWireframeInterface, view: NotifSpotViewInterface, interactor: NotifSpotInteractorInterface) {
        _wireframe = wireframe
        _view = view
        _interactor = interactor
    }
}

extension NotifSpotPresenter: NotifSpotPresenterInterface {
}
