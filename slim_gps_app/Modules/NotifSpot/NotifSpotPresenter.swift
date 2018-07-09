import Foundation

final class NotifSpotPresenter {
    
    private weak var _view: NotifSpotViewInterface?
    private var _wireframe: NotifSpotWireframeInterface
    private var _interactor: NotifSpotInteractorInterface
    
    init(wireframe: NotifSpotWireframeInterface, view: NotifSpotViewInterface, interactor: NotifSpotInteractorInterface) {
        _wireframe = wireframe
        _view = view
        _interactor = interactor
    }
}

extension NotifSpotPresenter: NotifSpotPresenterInterface {
    func addNotifSpot(name: String, latitude: Double, longitude: Double, radius: Double){
        print(2)
        _interactor.addNotifSpot(name: name, latitude: latitude, longitude: longitude, radius: radius)
    }
    
    func showNotifSpot(notif_spot_id: String, name: String, latitude: Double, longitude: Double, radius: Double){
        print(5)
        _view!.showNotifSpot(notif_spot_id: notif_spot_id, name: name, latitude: latitude, longitude: longitude, radius: radius)
    }
    
    func showAlert(message: String){
        _view!.showAlert(message: message)
    }
    
    func getNotifSpots(){
        _interactor.getNotifSpots()
    }
    
    func updateNotifSpot(notif_spot_id: String, name: String, tag: Int){
        _interactor.updateNotifSpot(notif_spot_id: notif_spot_id, name: name, tag: tag)
    }
    
    func deleteNotifSpot(notif_spot_id: String){
        _interactor.deleteNotifSpot(notif_spot_id: notif_spot_id)
    }
    
    func notifSpotIsUpdated(name: String, tag: Int){
        _view!.notifSpotIsUpdated(name: name, tag: tag)
    }
    
    func notifSpotIsDeleted(notif_spot_id: String){
        _view!.notifSpotIsDeleted(notif_spot_id: notif_spot_id)
    }

}
