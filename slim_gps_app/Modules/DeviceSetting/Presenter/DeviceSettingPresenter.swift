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
    
    func accessAuthIsGotten(watcher:(clientID: String, firstName: String, lastName: String, admin:Bool)){
        if let _view = _view {
            _view.accessAuthIsGotten(watcher:(clientID: watcher.clientID, firstName: watcher.firstName, lastName: watcher.lastName, admin:watcher.admin))
        }
    }
    
    func deleteAccessAuth(deviceID: String, clientID: String){
        _interactor.deleteAccessAuth(deviceID: deviceID, clientID: clientID)
    }
    
    func accessAuthIsDeleted(clientID: String){
        if let _view = _view {
            _view.accessAuthIsDeleted(clientID: clientID)
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

