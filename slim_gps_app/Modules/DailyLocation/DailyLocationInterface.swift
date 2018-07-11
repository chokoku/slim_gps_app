import UIKit

protocol DailyLocationPresenterInterface: class {
    
    // To View
    func showAlert(message: String)
    func locationDataIsEmpty()
    func locationDataIsGotten(data:(latitude: Double, longitude: Double, radius: Double, createdAt: Date, lastFlag: Bool))
    
    // To Interactor
    func getDailyLocation( serialNum: String, date: Date )
}

protocol DailyLocationViewInterface: class {
    func showAlert(message: String)
    func locationDataIsEmpty()
    func locationDataIsGotten(data:(latitude: Double, longitude: Double, radius: Double, createdAt: Date, lastFlag: Bool))
}

protocol DailyLocationInteractorInterface: class {
    func getDailyLocation( serialNum: String, date: Date )
}

protocol DailyLocationWireframeInterface: class {
}
