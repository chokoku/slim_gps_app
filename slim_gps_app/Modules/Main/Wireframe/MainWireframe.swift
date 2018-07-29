import UIKit
import SlideMenuControllerSwift

class MainWireframe {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)

    func configureModule() -> UIViewController {
        let viewController  = storyboard.instantiateViewController(withIdentifier: "Main") as! MainViewController
        let interactor = MainInteractor()
        let presenter = MainPresenter(wireframe: self, view: viewController, interactor: interactor)
        viewController.presenter = presenter
        interactor.presenter = presenter
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
}

extension MainWireframe: MainWireframeInterface {
    func pushDeviceSettingPage( deviceID: String, name: String, mode: String ){
        let nextVC = DeviceSettingWireframe().configureModule( deviceID: deviceID, name: name, mode: mode )
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let sideMenuController: SlideMenuController = appDelegate.window!.rootViewController as! SlideMenuController
        (sideMenuController.mainViewController as! UINavigationController).pushViewController(nextVC, animated: true)
        sideMenuController.closeLeft()
    }
    
    func pushLocationDataPage( deviceID: String, mode: String, latestLatitude: Double, latestLongitude: Double ){
        
        // "watching_powerSaving",
        // "watching_normal",
        // or "lost_proof"
        let nextVC = mode == "lost_proof" ? LocationSearchingWireframe().configureModule( deviceID: deviceID ) :
            LocationDataWireframe().configureModule( deviceID: deviceID, latestLatitude: latestLatitude, latestLongitude: latestLongitude )
        
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let sideMenuController: SlideMenuController = appDelegate.window!.rootViewController as! SlideMenuController
        (sideMenuController.mainViewController as! UINavigationController).pushViewController(nextVC, animated: true)
        sideMenuController.closeLeft()
    }
}
