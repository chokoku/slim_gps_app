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
    func getAccessAuth(device_id: String) -> [(access_auth_id: String?, first_name: String?, last_name: String?, admin: Bool?)]{
        return _interactor.fetchAccessAuth(device_id: device_id)
    }
    
    func removeAccessAuth(access_auth_id: String, completion: @escaping (String?) -> Void){
        var error: String?
        _interactor.deleteAccessAuth(access_auth_id: access_auth_id){ (err: String?) in
            if let err = err {
                error = err
            }
            completion(error)
        }
    }
    
    func changeDeviceName(device_id: String, name: String, completion: @escaping (String?) -> Void) {
        var error: String?
        _interactor.updateDeviceName(device_id: device_id, name: name){ (err: String?) in
            if let err = err {
                error = err
            }
            completion(error)
        }
    }
    
    func changeDeviceSetting(device_id: String, mode: String, completion: @escaping (String?) -> Void) {
        var error: String?
        _interactor.updateDeviceSetting( device_id: device_id, mode: mode ){ (err: String?) in
            if let err = err {
                error = err
            }
            completion(error)
        }
    }
}

