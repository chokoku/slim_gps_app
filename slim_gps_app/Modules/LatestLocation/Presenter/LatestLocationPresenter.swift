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
    func getNotifSpots(){
        _interactor.getNotifSpots()
    }
    
    func setLatestLocationListener( deviceID: String ){
        _interactor.setLatestLocationListener(deviceID: deviceID)
    }
    
    func removeSnapshotListener(){
        _interactor.removeSnapshotListener()
    }
    
    func locationDataIsGotten(latitude: Double, longitude: Double, radius: Double, updatedAt: Date){
        if let _view = _view {
            _view.locationDataIsGotten(latitude: latitude, longitude: longitude, radius: radius, updatedAt: updatedAt)
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
    
    func showNotifSpot(latitude: Double, longitude: Double, radius: Double){
        if let _view = _view {
            _view.showNotifSpot(latitude: latitude, longitude: longitude, radius: radius)
        }
    }
    
    func giveLastNotifSpotFlag(){
        if let _view = _view {
            _view.giveLastNotifSpotFlag()
        }
    }
}

