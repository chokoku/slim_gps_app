import UIKit
import SlideMenuControllerSwift

class DailyLocationWireframe {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    func configureModule( deviceID: String ) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "DailyLocation") as! DailyLocationViewController
        viewController.deviceID = deviceID
        let interactor = DailyLocationInteractor()
        let presenter = DailyLocationPresenter(wireframe: self, view: viewController, interactor: interactor)
        viewController.presenter = presenter
        interactor.presenter = presenter
        return viewController
    }
}

extension DailyLocationWireframe: DailyLocationWireframeInterface {
}
