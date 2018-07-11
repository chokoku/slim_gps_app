import UIKit

protocol DeviceSettingPresenterInterface: class {
    
    // To View
    func showAlert(message: String)
    func accessAuthIsGotten(watcher:(accessAuthID: String, firstName: String, lastName: String, admin:Bool))
    func accessAuthIsDeleted(accessAuthID: String)
    
    // To Interactor
    func getAccessAuth( deviceID: String )
    func deleteAccessAuth( accessAuthID: String )
    func updateDeviceName( deviceID: String, name:String )
    func updateDeviceSetting( deviceID: String, mode: String )
}

protocol DeviceSettingViewInterface: class {
    func showAlert(message: String)
    func accessAuthIsGotten(watcher:(accessAuthID: String, firstName: String, lastName: String, admin:Bool))
    func accessAuthIsDeleted(accessAuthID: String)
}

protocol DeviceSettingInteractorInterface: class {
    func getAccessAuth( deviceID: String )
    func deleteAccessAuth( accessAuthID: String )
    func updateDeviceName( deviceID: String, name:String )
    func updateDeviceSetting( deviceID: String, mode: String )
}

protocol DeviceSettingWireframeInterface: class {
}
