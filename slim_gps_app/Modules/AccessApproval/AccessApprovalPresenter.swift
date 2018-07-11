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
        _interactor.fetchRequesters(uid: user!.uid)
    }
    
    func addRequesters(accessAuthID: String, firstName: String?, lastName: String?){
        _view!.addRequesters(accessAuthID: accessAuthID, firstName: firstName, lastName: lastName)
    }
    
    func pushAlert(message:String){
        _view!.showAlert(message:message)
    }

    func approveAccessRequest(accessAuthID: String, completion: @escaping (String?) -> Void){
        var error: String?
        _interactor.approveAccessRequest(accessAuthID: accessAuthID){ (err: String?) in
            if let err = err {
                error = err
            }
            completion(error)
        }
    }
    
    func rejectAccessRequest(accessAuthID: String, completion: @escaping (String?) -> Void){
        var error: String?
        _interactor.rejectAccessRequest(accessAuthID: accessAuthID){ (err: String?) in
            if let err = err {
                error = err
            }
            completion(error)
        }
    }

}
