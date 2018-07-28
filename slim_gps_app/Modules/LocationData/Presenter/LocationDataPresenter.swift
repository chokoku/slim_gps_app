import Foundation

final class LocationDataPresenter {
    
    private weak var _view: LocationDataViewInterface?
    private var _wireframe: LocationDataWireframeInterface
    private var _interactor: LocationDataInteractorInterface
    
    init(wireframe: LocationDataWireframeInterface, view: LocationDataViewInterface, interactor: LocationDataInteractorInterface) {
        _wireframe = wireframe
        _view = view
        _interactor = interactor
    }
}

extension LocationDataPresenter: LocationDataPresenterInterface {

}

