import Foundation

final class SideMenuPresenter {
    
    private weak var _view: SideMenuViewInterface?
    private var _wireframe: SideMenuWireframeInterface
    
    init(wireframe: SideMenuWireframeInterface, view: SideMenuViewInterface) {
        _wireframe = wireframe
        _view = view
    }
}

extension SideMenuPresenter: SideMenuPresenterInterface {
    func getSideMenuPage(_ index: Int!){
        _wireframe.pushSideMenuPage(index)
    }
}


