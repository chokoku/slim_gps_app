import UIKit

final class NotifSpotWireframe {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    func configureModule() -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "NotifSpot") as! NotifSpotViewController
        let interactor = NotifSpotInteractor()
        let presenter = NotifSpotPresenter(wireframe: self, view: viewController, interactor: interactor)
        viewController.presenter = presenter
        interactor.output = presenter
        return viewController
    }
}

extension NotifSpotWireframe: NotifSpotWireframeInterface {
    
}
