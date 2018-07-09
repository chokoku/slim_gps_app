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
    func getLatestLocationData( serial_num: String, completion: @escaping (Double?, Double?, String?) -> Void ){
        _interactor.fetchLatestLocationData(serial_num: serial_num){ (latitude: Double?, longitude: Double?, err: String?) in
            if let err = err {
                completion(nil, nil, err)
            } else {
                completion(latitude, longitude, nil)
            }
        }
    }
    
    func goBackToMainPage() {
        _wireframe.popBackToMainPage()
    }
}

