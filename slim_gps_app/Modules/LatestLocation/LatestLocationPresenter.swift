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
    func getLatestLocationData( serialNum: String ){
        _interactor.getLatestLocationData(serialNum: serialNum)
    }
    
    func locationDataIsGotten(latitude: Double, longitude: Double, radius: Double){
        _view!.locationDataIsGotten(latitude: latitude, longitude: longitude, radius: radius)
    }
    
    func showAlert(message: String){
        _view!.showAlert(message: message)
    }
}

