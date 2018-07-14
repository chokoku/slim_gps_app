import UIKit

protocol DailyLocationPresenterInterface: class {
    
    // To View
    func showAlert(message: String)
    func locationDataIsEmpty()
    func locationDataIsGotten(data:(latitude: Double, longitude: Double, radius: Double, createdAt: Date))
    
    // To Interactor
    func setDailyLocationListener( deviceID: String, date: Date )
    func removeSnapshotListener()
}

protocol DailyLocationViewInterface: class {
    func showAlert(message: String)
    func locationDataIsEmpty()
    func locationDataIsGotten(data:(latitude: Double, longitude: Double, radius: Double, createdAt: Date))
}

protocol DailyLocationInteractorInterface: class {
    func setDailyLocationListener( deviceID: String, date: Date )
    func removeSnapshotListener()
}

protocol DailyLocationWireframeInterface: class {
}
