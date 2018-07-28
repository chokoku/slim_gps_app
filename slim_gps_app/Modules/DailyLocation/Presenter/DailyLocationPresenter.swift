import Foundation

final class DailyLocationPresenter {
    
    private weak var _view: DailyLocationViewInterface?
    private var _wireframe: DailyLocationWireframeInterface
    private var _interactor: DailyLocationInteractorInterface
    
    init(wireframe: DailyLocationWireframeInterface, view: DailyLocationViewInterface, interactor: DailyLocationInteractorInterface) {
        _wireframe = wireframe
        _view = view
        _interactor = interactor
    }
}

extension DailyLocationPresenter: DailyLocationPresenterInterface {
    func setDailyLocationListener( deviceID: String, date: Date ){
        _interactor.setDailyLocationListener( deviceID: deviceID, date: date )
    }
    
    func showAlert(message: String){
        if let _view = _view{
            _view.showAlert(message: message)
        }
    }
    
    func locationDataIsEmpty(){
        if let _view = _view{
            _view.locationDataIsEmpty()
        }
    }
    
    func locationDataIsGotten(data: (latitude: Double, longitude: Double, radius: Double, createdAt: Date), lastFlag: Bool){
        if let _view = _view{
            _view.locationDataIsGotten(data:(latitude: data.latitude, longitude: data.longitude, radius: data.radius, createdAt: data.createdAt))
            if lastFlag { _view.setBounds() }
        }
    }
}
