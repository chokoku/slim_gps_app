import UIKit

final class AccessApprovalWireframe {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    func configureModule() -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "AccessApproval") as! AccessApprovalViewController
        let interactor = AccessApprovalInteractor()
        let presenter = AccessApprovalPresenter(wireframe: self, view: viewController, interactor: interactor)
        viewController.presenter = presenter
        interactor.presenter = presenter
        return viewController
    }}

extension AccessApprovalWireframe: AccessApprovalWireframeInterface {
    
}
