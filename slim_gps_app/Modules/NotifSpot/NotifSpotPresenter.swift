import Foundation

final class NotifSpotPresenter {
    
    private weak var _view: NotifSpotViewInterface?
    private var _wireframe: NotifSpotWireframeInterface
    
    init(wireframe: NotifSpotWireframeInterface, view: NotifSpotViewInterface, interactor: NotifSpotInteractorInterface) {
        _wireframe = wireframe
        _view = view
    }
}

extension NotifSpotPresenter: NotifSpotPresenterInterface {
}
