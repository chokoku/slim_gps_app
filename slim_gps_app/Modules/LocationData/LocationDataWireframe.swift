import UIKit
import SlideMenuControllerSwift

class LocationDataWireframe {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    func configureModule( deviceID: String ) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "LocationData") as! LocationDataViewController
        viewController.deviceID = deviceID
        let interactor = LocationDataInteractor()
        let presenter = LocationDataPresenter(wireframe: self, view: viewController, interactor: interactor)
        viewController.presenter = presenter
        interactor.presenter = presenter
        return viewController
    }
}

extension LocationDataWireframe: LocationDataWireframeInterface {
}
