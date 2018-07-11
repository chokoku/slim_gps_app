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
    func getDailyLocation( serialNum: String, date: Date ){
        _interactor.getDailyLocation( serialNum: serialNum, date: date )
    }
    
    func showAlert(message: String){
        _view!.showAlert(message: message)
    }
    
    func locationDataIsEmpty(){
        _view!.locationDataIsEmpty()
    }
    
    func locationDataIsGotten(data:(latitude: Double, longitude: Double, radius: Double, createdAt: Date, lastFlag: Bool)){
        _view!.locationDataIsGotten(data:(latitude: data.latitude, longitude: data.longitude, radius: data.radius, createdAt: data.createdAt, lastFlag: data.lastFlag))
    }
}
