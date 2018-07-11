import UIKit

protocol SideMenuViewInterface: class {
}

protocol SideMenuWireframeInterface: class {
    func pushSideMenuPage(index: String)
}

protocol SideMenuPresenterInterface: class {
    func getSideMenuPage(index: String)
}
