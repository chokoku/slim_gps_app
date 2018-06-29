import UIKit

protocol SideMenuViewInterface: class {
}

protocol SideMenuWireframeInterface: class {
    func pushSideMenuPage(_ index: String)
}

protocol SideMenuPresenterInterface: class {
    func getSideMenuPage(_ index: String)
}
