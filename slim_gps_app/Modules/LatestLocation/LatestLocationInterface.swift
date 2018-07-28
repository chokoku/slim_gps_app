import UIKit

protocol LatestLocationPresenterInterface: class {
    
    // To View
    func locationDataIsGotten(latitude: Double, longitude: Double, radius: Double, updatedAt: Date)
    func showAlert(message: String)
    func locationDataIsEmpty(message: String)
    
    // To Interactor
    func setLatestLocationListener( deviceID: String )
    func removeSnapshotListener()

}

protocol LatestLocationViewInterface: class {
    func locationDataIsGotten(latitude: Double, longitude: Double, radius: Double, updatedAt: Date)
    func showAlert(message: String)
    func locationDataIsEmpty(message: String)
}

protocol LatestLocationInteractorInterface: class {
    func setLatestLocationListener( deviceID: String )
    func removeSnapshotListener()
}

protocol LatestLocationWireframeInterface: class {
}
