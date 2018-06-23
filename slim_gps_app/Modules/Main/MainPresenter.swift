import Foundation

final class MainPresenter {
    
    private weak var _view: MainViewInterface?
    private var _interactor: MainInteractorInterface
    private var _wireframe: MainWireframeInterface
    
    init(wireframe: MainWireframeInterface, view: MainViewInterface, interactor: MainInteractorInterface) {
        _wireframe = wireframe
        _view = view
        _interactor = interactor
    }
}

extension MainPresenter: MainPresenterInterface {

}


