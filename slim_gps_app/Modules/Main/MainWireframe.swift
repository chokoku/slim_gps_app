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
    func pushDeviceSettingPage( serial_num: String, name: String, mode: String ){
        print("move to \(serial_num) setting page")
        let nextVC = DeviceSettingWireframe().configureModule( serial_num: serial_num, name: name, mode: mode )
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let sideMenuController: SlideMenuController = appDelegate.window!.rootViewController as! SlideMenuController
        (sideMenuController.mainViewController as! UINavigationController).pushViewController(nextVC, animated: true)
        sideMenuController.closeLeft()
    }
    
    func pushLocationDataPage( serial_num: String ){
        print("move to \(serial_num) location data page")
        let nextVC = LocationDataWireframe().configureModule( serial_num: serial_num )
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let sideMenuController: SlideMenuController = appDelegate.window!.rootViewController as! SlideMenuController
        (sideMenuController.mainViewController as! UINavigationController).pushViewController(nextVC, animated: true)
        sideMenuController.closeLeft()
    }
}
