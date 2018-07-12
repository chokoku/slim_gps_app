import UIKit

protocol AccessApprovalPresenterInterface: class {
    
    // To View
    func addRequesters(accessAuthID:String, firstName:String?, lastName:String?)
    func showAlert(message: String)
    func accessAuthIsCompleted(accessAuthID: String)

    // To Interactor
    func getRequesters()
    func approveAccessRequest(accessAuthID: String)
    func rejectAccessRequest(accessAuthID: String)
}

protocol AccessApprovalViewInterface: class {
    func addRequesters(accessAuthID:String, firstName:String?, lastName:String?)
    func showAlert(message: String)
    func accessAuthIsCompleted(accessAuthID: String)
}

protocol AccessApprovalInteractorInterface: class {
    func getRequesters(uid:String)
    func approveAccessRequest(accessAuthID: String)
    func rejectAccessRequest(accessAuthID: String)
}

protocol AccessApprovalWireframeInterface: class {
}
