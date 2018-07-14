import UIKit

protocol MainPresenterInterface: class {

    // To View
    func addMapView(index: Int, lastFlag: Bool, deviceID: String, admin: Bool, mode: String, name: String, latitude: Double?, longitude: Double?, battery: Int?)
    func showAlert(message: String)
    
    // To Interactor
    func getDeviceInfo(uid: String)
    
    // To Wireframe
    func pushDeviceSettingPage( deviceID: String, name: String, mode: String )
    func pushLocationDataPage( deviceID: String, mode: String )
}

protocol MainViewInterface: class {
    func addMapView(index: Int, lastFlag: Bool, deviceID: String, admin: Bool, mode: String, name: String, latitude: Double?, longitude: Double?, battery: Int?)
    func showAlert(message: String)
}

protocol MainInteractorInterface: class {
    func getDeviceInfo(uid: String)
}

protocol MainWireframeInterface: class {
    func pushDeviceSettingPage( deviceID: String, name: String, mode: String )
    func pushLocationDataPage( deviceID: String, mode: String )
}
