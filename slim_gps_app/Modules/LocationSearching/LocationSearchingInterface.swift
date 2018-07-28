import UIKit

protocol LocationSearchingPresenterInterface: class {
    
    // To View
    func locationDataIsGotten(latitude: Double, longitude: Double, radius: Double, updatedAt: Date)
    func showAlert(message: String)
    func locationDataIsEmpty(message: String)
    
    // To Interactor
    func setLatestLocationListener( deviceID: String )
    func removeSnapshotListener()
    func requestLocationSearching(deviceID: String)
    
}

protocol LocationSearchingViewInterface: class {
    func locationDataIsGotten(latitude: Double, longitude: Double, radius: Double, updatedAt: Date)
    func showAlert(message: String)
    func locationDataIsEmpty(message: String)
}

protocol LocationSearchingInteractorInterface: class {
    func setLatestLocationListener( deviceID: String )
    func removeSnapshotListener()
    func requestLocationSearching(deviceID: String)
}

protocol LocationSearchingWireframeInterface: class {
}
