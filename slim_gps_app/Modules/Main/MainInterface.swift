import UIKit

protocol MainViewInterface: class {
}

protocol MainWireframeInterface: class {
    func pushDeviceSettingPage( serialNum: String, name: String, mode: String )
    func pushLocationDataPage( serialNum: String )
}

protocol MainPresenterInterface: class {
    func getDeviceSettingPage( serialNum: String, name: String, mode: String )
    func getLocationDataPage( serialNum: String )
    func getDeviceInfo(uid: String) -> [(serialNum: String?, admin: Bool?, mode: String?, name: String?, latitude: Double?, longitude: Double?, battery: Int?)]
}

protocol MainInteractorInterface: class {
    func fetchDeviceInfo(uid: String) -> [(serialNum: String?, admin: Bool?, mode: String?, name: String?, latitude: Double?, longitude: Double?, battery: Int?)]
}
