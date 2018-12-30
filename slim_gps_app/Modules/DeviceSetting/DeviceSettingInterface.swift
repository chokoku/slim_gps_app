import UIKit

protocol DeviceSettingPresenterInterface: class {
    
    // To View
    func showAlert(message: String)
    func accessAuthIsGotten(watcher:(clientID: String, firstName: String, lastName: String, admin:Bool))
    func accessAuthIsDeleted(clientID: String)
    
    // To Interactor
    func getAccessAuth( deviceID: String )
    func deleteAccessAuth( deviceID: String, clientID: String )
    func updateDeviceName( deviceID: String, name:String )
    func updateDeviceSetting( deviceID: String, mode: String )
}

protocol DeviceSettingViewInterface: class {
    func showAlert(message: String)
    func accessAuthIsGotten(watcher:(clientID: String, firstName: String, lastName: String, admin:Bool))
    func accessAuthIsDeleted(clientID: String)
}

protocol DeviceSettingInteractorInterface: class {
    func getAccessAuth( deviceID: String )
    func deleteAccessAuth( deviceID: String, clientID: String )
    func updateDeviceName( deviceID: String, name:String )
    func updateDeviceSetting( deviceID: String, mode: String )
}

protocol DeviceSettingWireframeInterface: class {
}
