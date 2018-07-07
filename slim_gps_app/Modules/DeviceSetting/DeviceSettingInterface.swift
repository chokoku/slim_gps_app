import UIKit

protocol DeviceSettingViewInterface: class {
}

protocol DeviceSettingWireframeInterface: class {
}

protocol DeviceSettingPresenterInterface: class {
    func getAccessAuth( device_id: String ) -> [(access_auth_id: String?, first_name: String?, last_name: String?, admin: Bool?)]
    func removeAccessAuth( access_auth_id: String )
    func changeDeviceName( device_id: String, name:String ) -> Bool
    func changeDeviceSetting( device_id: String, mode: String )
}

protocol DeviceSettingInteractorInterface: class {
    func fetchAccessAuth( device_id: String ) -> [(access_auth_id: String?, first_name: String?, last_name: String?, admin: Bool?)]
    func deleteAccessAuth( access_auth_id: String )
    func updateDeviceName( device_id: String, name:String ) -> Bool
    func updateDeviceSetting( device_id: String, mode: String )
}
