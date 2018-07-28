import UIKit

protocol DailyLocationPresenterInterface: class {
    
    // To View
    func showAlert(message: String)
    func locationDataIsEmpty()
    func locationDataIsGotten(data: (latitude: Double, longitude: Double, radius: Double, createdAt: Date), lastFlag: Bool)
    
    // To Interactor
    func setDailyLocationListener( deviceID: String, date: Date )
}

protocol DailyLocationViewInterface: class {
    func showAlert(message: String)
    func locationDataIsEmpty()
    func locationDataIsGotten(data:(latitude: Double, longitude: Double, radius: Double, createdAt: Date))
    func setBounds()
}

protocol DailyLocationInteractorInterface: class {
    func setDailyLocationListener( deviceID: String, date: Date )
}

protocol DailyLocationWireframeInterface: class {
}
