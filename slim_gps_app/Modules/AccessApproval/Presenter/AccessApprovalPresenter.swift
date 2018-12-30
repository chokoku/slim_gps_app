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
    
    func addRequesters(accessAuthReqID: String, firstName: String?, lastName: String?, clientID: String, deviceID: String){
        if let _view = _view{
            _view.addRequesters(accessAuthReqID: accessAuthReqID, firstName: firstName, lastName: lastName, clientID: clientID, deviceID: deviceID)
        }
    }

    func approveAccessRequest(accessAuthReqID: String, clientID: String, deviceID: String){
        _interactor.approveAccessRequest(accessAuthReqID: accessAuthReqID, clientID: clientID, deviceID: deviceID)
    }
    
    func rejectAccessRequest(accessAuthReqID: String){
        let user = Auth.auth().currentUser
        _interactor.rejectAccessRequest(accessAuthReqID: accessAuthReqID, uid: user!.uid)
    }
    
    func accessAuthIsCompleted(accessAuthReqID: String){
        if let _view = _view{
            _view.accessAuthIsCompleted(accessAuthReqID: accessAuthReqID)
        }
    }
    
    func showAlert(message:String){
        if let _view = _view{
            _view.showAlert(message:message)
        }
    }
}
