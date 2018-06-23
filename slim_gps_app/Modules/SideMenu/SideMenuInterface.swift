import UIKit

protocol SideMenuViewInterface: class {
}

protocol SideMenuWireframeInterface: class {
    func pushSideMenuPage(_ index: Int!)
}

protocol SideMenuPresenterInterface: class {
    func getSideMenuPage(_ index: Int!)
}
