import UIKit

protocol NotifSpotViewInterface: class {
    func showNotifSpot(notif_spot_id: String, name: String, latitude: Double, longitude: Double, radius: Double)
    func showAlert(message: String)
    func notifSpotIsUpdated(name: String, tag: Int)
    func notifSpotIsDeleted(notif_spot_id: String)
}

protocol NotifSpotWireframeInterface: class {
}

protocol NotifSpotPresenterInterface: class {
    func addNotifSpot(name: String, latitude: Double, longitude: Double, radius: Double)
    func showNotifSpot(notif_spot_id: String, name: String, latitude: Double, longitude: Double, radius: Double)
    func showAlert(message: String)
    func getNotifSpots()
    func updateNotifSpot(notif_spot_id: String, name: String, tag: Int)
    func deleteNotifSpot(notif_spot_id: String)
    func notifSpotIsUpdated(name: String, tag: Int)
    func notifSpotIsDeleted(notif_spot_id: String)
}

protocol NotifSpotInteractorInterface: class {
    func addNotifSpot(name: String, latitude: Double, longitude: Double, radius: Double)
    func getNotifSpots()
    func updateNotifSpot(notif_spot_id: String, name: String, tag: Int)
    func deleteNotifSpot(notif_spot_id: String)
}
