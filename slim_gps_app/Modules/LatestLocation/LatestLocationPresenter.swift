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
    func getLatestLocationData(serial_num: String) -> (latitude: Double?, longitude: Double?){
        let locationData:(latitude: Double?, longitude: Double?) = _interactor.fetchLatestLocationData(serial_num: serial_num)
        return locationData
    }
    
    func goBackToMainPage() {
        _wireframe.popBackToMainPage()
    }
}

