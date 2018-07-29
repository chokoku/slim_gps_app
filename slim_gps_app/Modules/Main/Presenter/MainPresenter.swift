import Foundation
import FirebaseAuth

final class MainPresenter {
    
    private weak var _view: MainViewInterface?
    private var _wireframe: MainWireframeInterface
    private var _interactor: MainInteractorInterface
    
    init(wireframe: MainWireframeInterface, view: MainViewInterface, interactor: MainInteractorInterface) {
        _wireframe = wireframe
        _view = view
        _interactor = interactor
    }
}

extension MainPresenter: MainPresenterInterface {
    
    func getDeviceInfo(uid: String){
        _interactor.getDeviceInfo(uid: uid)
    }
    
    func addMapView(index: Int, lastFlag: Bool, deviceID: String, admin: Bool, mode: String, name: String, latitude: Double?, longitude: Double?, battery: Int?){
        if let _view = _view {
            _view.addMapView(index: index, lastFlag: lastFlag, deviceID: deviceID, admin: admin, mode: mode, name: name, latitude: latitude, longitude: longitude, battery: battery)
        }
    }
    
    func showAlert(message: String){
        if let _view = _view {
            _view.showAlert(message: message)
        }
    }
    
    func pushDeviceSettingPage( deviceID: String, name: String, mode: String ){
        _wireframe.pushDeviceSettingPage( deviceID: deviceID, name: name, mode: mode )
    }
    
    func pushLocationDataPage( deviceID: String, mode: String, latestLatitude: Double, latestLongitude: Double ){
        _wireframe.pushLocationDataPage( deviceID: deviceID, mode: mode, latestLatitude: latestLatitude, latestLongitude: latestLongitude )
    }
    
}


