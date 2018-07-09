import UIKit

protocol UserInfoViewInterface: class {
}

protocol UserInfoPresenterInterface: class {
    func logout()
    
    func getUserInfo(completion: @escaping ([String:String?], String?) -> Void)
    func updateUserEmail(email: String, password: String, completion: @escaping (String?) -> Void)
    func updateUserInfo(item: String, input: String, completion: @escaping (String?) ->Void)
}

protocol UserInfoWireframeInterface: class {
    func getMainPage()
}

protocol UserInfoInteractorInterface: class {
    func fetchClientInfo(uid: String, completion: @escaping ([String:String?], String?) -> Void)
    func updateClientEmail(email: String, completion: @escaping (String?) ->Void)
    func updateClientInfo(uid: String, item: String, input: String, completion: @escaping (String?) -> Void)
}
