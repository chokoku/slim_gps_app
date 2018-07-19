import Foundation

final class LatestLocationPresenter {
    
    private weak var _view: LatestLocationViewInterface?
    private var _wireframe: LatestLocationWireframeInterface
    private var _interactor: LatestLocationInteractorInterface
    
    init(wireframe: LatestLocationWireframeInterface, view: LatestLocationViewInterface, interactor: LatestLocationInteractorInterface) {
        _wireframe = wireframe
        _view = view
        _interactor = interactor
    }
}

extension LatestLocationPresenter: LatestLocationPresenterInterface {
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
    
    func locationDataIsEmpty(message: String){
        if let _view = _view {
            _view.locationDataIsEmpty(message: message)
        }
    }

}

