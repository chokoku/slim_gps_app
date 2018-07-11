import UIKit

protocol AccessApprovalPresenterInterface: class {
    
    // To View
    func showAlert(message:String)
    func addRequesters(accessAuthID:String, firstName:String?, lastName:String?)

    // To Interactor
    func getRequesters()
    func approveAccessRequest(accessAuthID: String, completion: @escaping (String?) -> Void)
    func rejectAccessRequest(accessAuthID: String, completion: @escaping (String?) -> Void)
}

protocol AccessApprovalViewInterface: class {
    func addRequesters(accessAuthID:String, firstName:String?, lastName:String?)
    func showAlert(message:String)
}

protocol AccessApprovalInteractorInterface: class {
    func getRequesters(uid:String)
    func approveAccessRequest(accessAuthID: String, completion: @escaping (String?) -> Void)
    func rejectAccessRequest(accessAuthID: String, completion: @escaping (String?) -> Void)
}

protocol AccessApprovalWireframeInterface: class {
}
