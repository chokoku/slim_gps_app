import UIKit

protocol NotifSpotViewInterface: class {
    func showNotifSpot(notifSpotID: String, name: String, latitude: Double, longitude: Double, radius: Double)
    func showAlert(message: String)
    func notifSpotIsUpdated(name: String, tag: Int)
    func notifSpotIsDeleted(notifSpotID: String)
}

protocol NotifSpotWireframeInterface: class {
}

protocol NotifSpotPresenterInterface: class {
    func addNotifSpot(name: String, latitude: Double, longitude: Double, radius: Double)
    func showNotifSpot(notifSpotID: String, name: String, latitude: Double, longitude: Double, radius: Double)
    func showAlert(message: String)
    func getNotifSpots()
    func updateNotifSpot(notifSpotID: String, name: String, tag: Int)
    func deleteNotifSpot(notifSpotID: String)
    func notifSpotIsUpdated(name: String, tag: Int)
    func notifSpotIsDeleted(notifSpotID: String)
}

protocol NotifSpotInteractorInterface: class {
    func addNotifSpot(name: String, latitude: Double, longitude: Double, radius: Double)
    func getNotifSpots()
    func updateNotifSpot(notifSpotID: String, name: String, tag: Int)
    func deleteNotifSpot(notifSpotID: String)
}
