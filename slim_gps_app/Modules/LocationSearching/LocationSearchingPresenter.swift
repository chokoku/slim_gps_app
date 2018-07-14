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
    func getLatestLocationData( serialNum: String ){
        _interactor.getLatestLocationData(serialNum: serialNum)
    }
    
    func locationDataIsGotten(latitude: Double, longitude: Double, radius: Double, createdAt: Date){
        _view!.locationDataIsGotten(latitude: latitude, longitude: longitude, radius: radius, createdAt: createdAt)
    }
    
    func showAlert(message: String){
        _view!.showAlert(message: message)
    }
    
    func requestLocationSearching(deviceID: String){
        _interactor.requestLocationSearching(deviceID: deviceID)
    }
}

