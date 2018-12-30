import UIKit

protocol AccessApprovalPresenterInterface: class {
    
    // To View
    func addRequesters(accessAuthReqID: String, firstName: String?, lastName: String?, clientID: String, deviceID: String)
    func showAlert(message: String)
    func accessAuthIsCompleted(accessAuthReqID: String)

    // To Interactor
    func getRequesters()
    func approveAccessRequest(accessAuthReqID: String, clientID: String, deviceID: String)
    func rejectAccessRequest(accessAuthReqID: String)
}

protocol AccessApprovalViewInterface: class {
    func addRequesters(accessAuthReqID: String, firstName: String?, lastName: String?, clientID: String, deviceID: String)
    func showAlert(message: String)
    func accessAuthIsCompleted(accessAuthReqID: String)
}

protocol AccessApprovalInteractorInterface: class {
    func getRequesters(uid:String)
    func approveAccessRequest(accessAuthReqID: String, clientID: String, deviceID: String)
    func rejectAccessRequest(accessAuthReqID: String, uid: String)
}

protocol AccessApprovalWireframeInterface: class {
}
