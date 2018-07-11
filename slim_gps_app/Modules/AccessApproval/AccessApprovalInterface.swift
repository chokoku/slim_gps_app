import UIKit

protocol AccessApprovalViewInterface: class {
    func addRequesters(accessAuthID:String, firstName:String?, lastName:String?)
    func showAlert(message:String)
}

protocol AccessApprovalWireframeInterface: class {
}

protocol AccessApprovalPresenterInterface: class {
    func getRequesters()
    func addRequesters(accessAuthID:String, firstName:String?, lastName:String?)
    func pushAlert(message:String)
    func approveAccessRequest(accessAuthID: String, completion: @escaping (String?) -> Void)
    func rejectAccessRequest(accessAuthID: String, completion: @escaping (String?) -> Void)
}

protocol AccessApprovalInteractorInterface: class {
    func fetchRequesters(uid:String)
    func approveAccessRequest(accessAuthID: String, completion: @escaping (String?) -> Void)
    func rejectAccessRequest(accessAuthID: String, completion: @escaping (String?) -> Void)
}
