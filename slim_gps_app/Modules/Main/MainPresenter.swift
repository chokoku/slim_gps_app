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
    func getDeviceSettingPage( serial_num: String, name: String, mode: String ){
        _wireframe.pushDeviceSettingPage( serial_num: serial_num, name: name, mode: mode )
    }
    
    func getLocationDataPage( serial_num: String ){
        _wireframe.pushLocationDataPage( serial_num: serial_num )
    }
    
    func getDeviceInfo(uid: String) -> [(serial_num: String?, admin: Bool?, mode: String?, name: String?, latitude: Double?, longitude: Double?, battery: Int?)]{
        return _interactor.fetchDeviceInfo(uid: uid)
    }
    
}


