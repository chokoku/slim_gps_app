import UIKit

protocol LatestLocationPresenterInterface: class {
    
    // To View
    func locationDataIsGotten(latitude: Double, longitude: Double, radius: Double)
    func showAlert(message: String)
    
    // To Interactor
    func getLatestLocationData( serialNum: String )

}

protocol LatestLocationViewInterface: class {
    func locationDataIsGotten(latitude: Double, longitude: Double, radius: Double)
    func showAlert(message: String)
}

protocol LatestLocationInteractorInterface: class {
    func getLatestLocationData( serialNum: String )
}

protocol LatestLocationWireframeInterface: class {
}
