import UIKit

protocol DeviceSettingViewInterface: class {
}

protocol DeviceSettingWireframeInterface: class {
}

protocol DeviceSettingPresenterInterface: class {
    func getAccessAuth( device_id: String ) -> [(access_auth_id: String?, first_name: String?, last_name: String?, admin: Bool?)]
    func removeAccessAuth( access_auth_id: String, completion: @escaping (String?) -> Void )
    func changeDeviceName( device_id: String, name:String, completion: @escaping (String?) -> Void )
    func changeDeviceSetting( device_id: String, mode: String, completion: @escaping (String?) -> Void )
}

protocol DeviceSettingInteractorInterface: class {
    func fetchAccessAuth( device_id: String ) -> [(access_auth_id: String?, first_name: String?, last_name: String?, admin: Bool?)]
    func deleteAccessAuth( access_auth_id: String, completion: @escaping (String?) -> Void )
    func updateDeviceName( device_id: String, name:String, completion: @escaping (String?) -> Void )
    func updateDeviceSetting( device_id: String, mode: String, completion: @escaping (String?) -> Void )
}
