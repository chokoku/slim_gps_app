import UIKit

protocol DeviceSettingPresenterInterface: class {
    
    // To Interactor
    func getAccessAuth( deviceID: String ) -> [(accessAuthID: String?, firstName: String?, lastName: String?, admin: Bool?)]
    func deleteAccessAuth( accessAuthID: String, completion: @escaping (String?) -> Void )
    func updateDeviceName( deviceID: String, name:String, completion: @escaping (String?) -> Void )
    func updateDeviceSetting( deviceID: String, mode: String, completion: @escaping (String?) -> Void )
}

protocol DeviceSettingViewInterface: class {
}

protocol DeviceSettingInteractorInterface: class {
    func getAccessAuth( deviceID: String ) -> [(accessAuthID: String?, firstName: String?, lastName: String?, admin: Bool?)]
    func deleteAccessAuth( accessAuthID: String, completion: @escaping (String?) -> Void )
    func updateDeviceName( deviceID: String, name:String, completion: @escaping (String?) -> Void )
    func updateDeviceSetting( deviceID: String, mode: String, completion: @escaping (String?) -> Void )
}

protocol DeviceSettingWireframeInterface: class {
}
