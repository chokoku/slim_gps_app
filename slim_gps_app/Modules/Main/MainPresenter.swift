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
    func pushDeviceSettingPage( serialNum: String, name: String, mode: String ){
        _wireframe.pushDeviceSettingPage( serialNum: serialNum, name: name, mode: mode )
    }
    
    func pushLocationDataPage( serialNum: String ){
        _wireframe.pushLocationDataPage( serialNum: serialNum )
    }
    
    func getDeviceInfo(uid: String) -> [(serialNum: String?, admin: Bool?, mode: String?, name: String?, latitude: Double?, longitude: Double?, battery: Int?)]{
        return _interactor.getDeviceInfo(uid: uid)
    }
    
}


