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
    func getDailyLocation( serialNum: String, date: Date ) -> [(latitude: Double, longitude: Double, createdAt: Date)]{
        let locationData:[(latitude: Double, longitude: Double, createdAt: Date)] = _interactor.fetchDailyLocation( serialNum: serialNum, date: date )
        return locationData
    }
}
