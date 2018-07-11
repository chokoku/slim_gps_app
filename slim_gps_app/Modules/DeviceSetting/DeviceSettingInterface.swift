import UIKit

protocol DeviceSettingViewInterface: class {
}

protocol DeviceSettingWireframeInterface: class {
}

protocol DeviceSettingPresenterInterface: class {
    func getAccessAuth( deviceID: String ) -> [(accessAuthID: String?, firstName: String?, lastName: String?, admin: Bool?)]
    func removeAccessAuth( accessAuthID: String, completion: @escaping (String?) -> Void )
    func changeDeviceName( deviceID: String, name:String, completion: @escaping (String?) -> Void )
    func changeDeviceSetting( deviceID: String, mode: String, completion: @escaping (String?) -> Void )
}

protocol DeviceSettingInteractorInterface: class {
    func fetchAccessAuth( deviceID: String ) -> [(accessAuthID: String?, firstName: String?, lastName: String?, admin: Bool?)]
    func deleteAccessAuth( accessAuthID: String, completion: @escaping (String?) -> Void )
    func updateDeviceName( deviceID: String, name:String, completion: @escaping (String?) -> Void )
    func updateDeviceSetting( deviceID: String, mode: String, completion: @escaping (String?) -> Void )
}
