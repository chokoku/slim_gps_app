import Foundation
import FirebaseAuth

final class AccessApprovalPresenter {

    private weak var _view: AccessApprovalViewInterface?
    private var _wireframe: AccessApprovalWireframeInterface
    private var _interactor: AccessApprovalInteractorInterface
    
    init(wireframe: AccessApprovalWireframeInterface, view: AccessApprovalViewInterface, interactor: AccessApprovalInteractorInterface) {
        _wireframe = wireframe
        _view = view
        _interactor = interactor
    }
}

extension AccessApprovalPresenter: AccessApprovalPresenterInterface {
    func getRequesters() {
        let user = Auth.auth().currentUser
        _interactor.getRequesters(uid: user!.uid)
    }
    
    func addRequesters(accessAuthID: String, firstName: String?, lastName: String?){
        _view!.addRequesters(accessAuthID: accessAuthID, firstName: firstName, lastName: lastName)
    }

    func approveAccessRequest(accessAuthID: String){
        _interactor.approveAccessRequest(accessAuthID: accessAuthID)
    }
    
    func rejectAccessRequest(accessAuthID: String){
        _interactor.rejectAccessRequest(accessAuthID: accessAuthID)
    }
    
    func accessAuthIsCompleted(accessAuthID: String){
        _view!.accessAuthIsCompleted(accessAuthID: accessAuthID)
    }
    
    func showAlert(message:String){
        _view!.showAlert(message:message)
    }
}
