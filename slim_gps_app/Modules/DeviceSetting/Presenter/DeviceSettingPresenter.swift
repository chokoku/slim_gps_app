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
    func getAccessAuth(deviceID: String) {
        _interactor.getAccessAuth(deviceID: deviceID)
    }
    
    func accessAuthIsGotten(watcher:(accessAuthID: String, firstName: String, lastName: String, admin:Bool)){
        if let _view = _view {
            _view.accessAuthIsGotten(watcher:(accessAuthID: watcher.accessAuthID, firstName: watcher.firstName, lastName: watcher.lastName, admin:watcher.admin))
        }
    }
    
    func deleteAccessAuth(accessAuthID: String){
        _interactor.deleteAccessAuth(accessAuthID: accessAuthID)
    }
    
    func accessAuthIsDeleted(accessAuthID: String){
        if let _view = _view {
            _view.accessAuthIsDeleted(accessAuthID: accessAuthID)
        }
    }
    
    func updateDeviceName(deviceID: String, name: String) {
        _interactor.updateDeviceName(deviceID: deviceID, name: name)
    }
    
    func updateDeviceSetting(deviceID: String, mode: String) {
        _interactor.updateDeviceSetting( deviceID: deviceID, mode: mode )
    }
    
    func showAlert(message: String){
        if let _view = _view {
            _view.showAlert(message: message)
        }
    }
}

