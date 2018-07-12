import UIKit

protocol MainPresenterInterface: class {

    // To Interactor
    func getDeviceInfo(uid: String) -> [(serialNum: String?, admin: Bool?, mode: String?, name: String?, latitude: Double?, longitude: Double?, battery: Int?)]
    
    // To Wireframe
    func pushDeviceSettingPage( serialNum: String, name: String, mode: String )
    func pushLocationDataPage( serialNum: String, mode: String )
}

protocol MainViewInterface: class {
}

protocol MainInteractorInterface: class {
    func getDeviceInfo(uid: String) -> [(serialNum: String?, admin: Bool?, mode: String?, name: String?, latitude: Double?, longitude: Double?, battery: Int?)]
}

protocol MainWireframeInterface: class {
    func pushDeviceSettingPage( serialNum: String, name: String, mode: String )
    func pushLocationDataPage( serialNum: String, mode: String )
}
