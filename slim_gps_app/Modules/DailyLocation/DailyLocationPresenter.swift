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
    func getDailyLocation( serial_num: String, date: Date ) -> [(latitude: Double, longitude: Double, created_at: NSObject)]{
        let locationData:[(latitude: Double, longitude: Double, created_at: NSObject)] = _interactor.fetchDailyLocation( serial_num: serial_num, date: date )
        return locationData
    }
}
