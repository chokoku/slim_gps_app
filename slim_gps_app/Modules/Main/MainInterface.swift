import UIKit

protocol MainViewInterface: class {
}

protocol MainWireframeInterface: class {
    func pushDeviceSettingPage( serial_num: String, name: String, mode: String )
    func pushLocationDataPage( serial_num: String )
}

protocol MainPresenterInterface: class {
    func getDeviceSettingPage( serial_num: String, name: String, mode: String )
    func getLocationDataPage( serial_num: String )
    func getDeviceInfo(uid: String) -> [(serial_num: String?, admin: Bool?, mode: String?, name: String?, latitude: Double?, longitude: Double?, battery: Int?)]
}

protocol MainInteractorInterface: class {
    func fetchDeviceInfo(uid: String) -> [(serial_num: String?, admin: Bool?, mode: String?, name: String?, latitude: Double?, longitude: Double?, battery: Int?)]
}
