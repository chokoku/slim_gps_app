import Foundation

final class DeviceSettingPresenter {
    
    private weak var _view: DeviceSettingViewInterface?
    private var _wireframe: DeviceSettingWireframeInterface
    private var _interactor: DeviceSettingInteractorInterface
    
    init(wireframe: DeviceSettingWireframeInterface, view: DeviceSettingViewInterface, interactor: DeviceSettingInteractorInterface) {
        _wireframe = wireframe
        _view = view
        _interactor = interactor
    }
}

extension DeviceSettingPresenter: DeviceSettingPresenterInterface {
    func getAccessAuth(deviceID: String) -> [(accessAuthID: String?, firstName: String?, lastName: String?, admin: Bool?)]{
        return _interactor.getAccessAuth(deviceID: deviceID)
    }
    
    func deleteAccessAuth(accessAuthID: String, completion: @escaping (String?) -> Void){
        var error: String?
        _interactor.deleteAccessAuth(accessAuthID: accessAuthID){ (err: String?) in
            if let err = err {
                error = err
            }
            completion(error)
        }
    }
    
    func updateDeviceName(deviceID: String, name: String, completion: @escaping (String?) -> Void) {
        var error: String?
        _interactor.updateDeviceName(deviceID: deviceID, name: name){ (err: String?) in
            if let err = err {
                error = err
            }
            completion(error)
        }
    }
    
    func updateDeviceSetting(deviceID: String, mode: String, completion: @escaping (String?) -> Void) {
        var error: String?
        _interactor.updateDeviceSetting( deviceID: deviceID, mode: mode ){ (err: String?) in
            if let err = err {
                error = err
            }
            completion(error)
        }
    }
}

