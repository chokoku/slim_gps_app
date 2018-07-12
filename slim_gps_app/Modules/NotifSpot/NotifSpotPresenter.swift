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
        _interactor.addNotifSpot(name: name, latitude: latitude, longitude: longitude, radius: radius)
    }
    
    func showNotifSpot(notifSpotID: String, name: String, latitude: Double, longitude: Double, radius: Double){
        _view!.showNotifSpot(notifSpotID: notifSpotID, name: name, latitude: latitude, longitude: longitude, radius: radius)
    }
    
    func showAlert(message: String){
        _view!.showAlert(message: message)
    }
    
    func getNotifSpots(){
        _interactor.getNotifSpots()
    }
    
    func updateNotifSpot(notifSpotID: String, name: String, tag: Int){
        _interactor.updateNotifSpot(notifSpotID: notifSpotID, name: name, tag: tag)
    }
    
    func deleteNotifSpot(notifSpotID: String){
        _interactor.deleteNotifSpot(notifSpotID: notifSpotID)
    }
    
    func notifSpotIsUpdated(name: String, tag: Int){
        _view!.notifSpotIsUpdated(name: name, tag: tag)
    }
    
    func notifSpotIsDeleted(notifSpotID: String){
        _view!.notifSpotIsDeleted(notifSpotID: notifSpotID)
    }

}
