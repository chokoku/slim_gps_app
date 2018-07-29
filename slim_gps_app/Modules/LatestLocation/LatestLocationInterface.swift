import UIKit

protocol LatestLocationPresenterInterface: class {
    
    // To View
    func locationDataIsGotten(latitude: Double, longitude: Double, radius: Double, updatedAt: Date)
    func showAlert(message: String)
    func locationDataIsEmpty(message: String)
    func showNotifSpot(latitude: Double, longitude: Double, radius: Double)
    func giveLastNotifSpotFlag()
    
    // To Interactor
    func getNotifSpots()
    func setLatestLocationListener( deviceID: String )
    func removeSnapshotListener()

}

protocol LatestLocationViewInterface: class {
    func locationDataIsGotten(latitude: Double, longitude: Double, radius: Double, updatedAt: Date)
    func showAlert(message: String)
    func locationDataIsEmpty(message: String)
    func showNotifSpot(latitude: Double, longitude: Double, radius: Double)
    func giveLastNotifSpotFlag()
}

protocol LatestLocationInteractorInterface: class {
    func getNotifSpots()
    func setLatestLocationListener( deviceID: String )
    func removeSnapshotListener()
}

protocol LatestLocationWireframeInterface: class {
}
