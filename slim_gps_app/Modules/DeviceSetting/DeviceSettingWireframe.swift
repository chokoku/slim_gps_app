import UIKit
import SlideMenuControllerSwift

class DeviceSettingWireframe {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    func configureModule( deviceID: String, name: String, mode: String ) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "DeviceSetting") as! DeviceSettingViewController
        viewController.serialNum = deviceID
        viewController.name = name
        viewController.mode = mode

        let interactor = DeviceSettingInteractor()
        let presenter = DeviceSettingPresenter(wireframe: self, view: viewController, interactor: interactor)
        viewController.presenter = presenter
        interactor.presenter = presenter
        return viewController
    }
}

extension DeviceSettingWireframe: DeviceSettingWireframeInterface {
//    func pushDeviceSettingPage(_ serialNum:String){
//        print("move to \(serialNum) setting page")
//        let nextVC = DeviceSettingWireframe().configureModule(serialNum)
//        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
//        let sideMenuController: SlideMenuController = appDelegate.window!.rootViewController as! SlideMenuController
//        (sideMenuController.mainViewController as! UINavigationController).pushViewController(nextVC, animated: true)
//        sideMenuController.closeLeft()
//    }
}
