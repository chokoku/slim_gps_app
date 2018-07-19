import Foundation

final class LocationSearchingPresenter {
    
    private weak var _view: LocationSearchingViewInterface?
    private var _wireframe: LocationSearchingWireframeInterface
    private var _interactor: LocationSearchingInteractorInterface
    
    init(wireframe: LocationSearchingWireframeInterface, view: LocationSearchingViewInterface, interactor: LocationSearchingInteractorInterface) {
        _wireframe = wireframe
        _view = view
        _interactor = interactor
    }
}

extension LocationSearchingPresenter: LocationSearchingPresenterInterface {
    func setLatestLocationListener( deviceID: String ){
        _interactor.setLatestLocationListener(deviceID: deviceID)
    }
    
    func removeSnapshotListener(){
        _interactor.removeSnapshotListener()
    }
    
    func locationDataIsGotten(latitude: Double, longitude: Double, radius: Double, createdAt: Date){
        if let _view = _view {
            _view.locationDataIsGotten(latitude: latitude, longitude: longitude, radius: radius, createdAt: createdAt)
        }
    }
    
    func showAlert(message: String){
        if let _view = _view {
            _view.showAlert(message: message)
        }
    }
    
    func requestLocationSearching(deviceID: String){
        _interactor.requestLocationSearching(deviceID: deviceID)
    }
    
    func locationDataIsEmpty(message: String){
        if let _view = _view {
            _view.locationDataIsEmpty(message: message)
        }
    }
}

